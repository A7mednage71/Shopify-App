/**
 * Gemini Secure Backend Proxy for Shopify Shoe Store App
 * 
 * Securely forwards assistant queries to Gemini API without exposing the API key on the client.
 * Designed for Firebase Functions.
 */

const { onRequest } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const axios = require("axios");

// Define a Cloud Secret for the Gemini API Key
const geminiApiKey = defineSecret("GEMINI_API_KEY");

exports.geminiProxy = onRequest({ secrets: [geminiApiKey], cors: true }, async (req, res) => {
    // Handle preflight requests
    if (req.method === "OPTIONS") {
        res.status(204).send("");
        return;
    }

    try {
        const { history, products } = req.body;

        if (!history || !Array.isArray(history)) {
            res.status(400).json({ error: "Missing or invalid history array" });
            return;
        }

        // Get the API Key from Secret Manager
        const apiKey = geminiApiKey.value();
        if (!apiKey) {
            res.status(500).json({ error: "Gemini API key is not configured in the Firebase Secret Manager." });
            return;
        }

        // Format products list into a compact JSON string to inject into the system instructions
        const catalogJSON = JSON.stringify(products || []);

        const systemInstruction = `انت مساعد تسوق ذكي لمتجر أحذية رياضية على شوبيفاي.
عندك قايمة المنتجات المتاحة دي فقط، ومينفعش تقترح أي حاجة مش موجودة فيها:
${catalogJSON}

القواعد:
- جاوب بالعربي المصري، ودود ومختصر جداً.
- اقترح أقرب 1-4 منتجات مطابقة من القايمة فقط باستخدام الـ id بتاعهم.
- لو مفيش تطابق، قوله بصراحة إنه مش متوفر واقترح البديل الأقرب.
- رجّع الرد بصيغة JSON فقط بالشكل ده بالظبط:
{"reply": "نص الرد هنا", "product_ids": ["p1", "p4"]}
لو مفيش منتجات مناسبة خليها array فاضية [].`;

        // Map conversation history to Gemini contents format
        const contents = history.map(msg => ({
            role: msg.role === "user" ? "user" : "model",
            parts: [{ text: msg.text }]
        }));

        const body = {
            system_instruction: { parts: [{ text: systemInstruction }] },
            contents: contents,
            generationConfig: {
                responseMimeType: "application/json"
            }
        };

        const response = await axios.post(
            `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${apiKey}`,
            body,
            { headers: { "Content-Type": "application/json" }, timeout: 10000 }
        );

        const candidates = response.data.candidates;
        if (!candidates || candidates.length === 0) {
            res.status(502).json({ error: "Empty response from Gemini API" });
            return;
        }

        const replyText = candidates[0].content.parts[0].text;
        
        try {
            const parsedReply = JSON.parse(replyText);
            res.status(200).json(parsedReply);
        } catch (e) {
            res.status(200).json({
                reply: replyText,
                product_ids: []
            });
        }

    } catch (error) {
        console.error("Error in geminiProxy:", error);
        const statusCode = error.response ? error.response.status : 500;
        res.status(statusCode).json({ error: error.message });
    }
});
