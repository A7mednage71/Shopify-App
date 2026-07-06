import Foundation

struct GeminiShoppingAssistantRequestBuilder {
    
    init() {}
    
    func buildSystemInstruction(catalog: [ShopProduct]) throws -> String {
        let aiProducts = catalog.map { $0.toAICatalogProduct() }
        let catalogJSONData = try JSONEncoder().encode(aiProducts)
        let catalogJSON = String(data: catalogJSONData, encoding: .utf8) ?? "[]"
        
        return """
        You are a smart, professional shopping assistant for a Shopify sportswear shoe store.
        Here is the list of available products in our catalog. You must ONLY recommend products from this list:
        \(catalogJSON)

        Rules:
        - Respond in English. Be friendly, professional, and concise.
        - Recommend the closest matching 1-4 products from the catalog list by returning their exact 'id's in the product_ids array.
        - If no products match, tell the user politely and recommend the closest alternative.
        - Return the response strictly as a JSON object with this exact shape:
        {"reply": "your message here", "product_ids": ["p1", "p4"]}
        If no products are relevant, return an empty array [] for "product_ids".
        """
    }
    
    func getOptimizedHistory(from messages: [ChatMessage]) -> [GeminiRequestMessage] {
        let maxContext = 10
        let recentMessages = messages.suffix(maxContext)
        return recentMessages.map { msg in
            GeminiRequestMessage(
                role: msg.role == .user ? "user" : "model",
                text: msg.text
            )
        }
    }
    
    func buildRequestBody(messages: [ChatMessage], catalog: [ShopProduct]) throws -> GeminiDirectRequestBody {
        let systemInstructionText = try buildSystemInstruction(catalog: catalog)
        let optimizedHistory = getOptimizedHistory(from: messages)
        
        let contents = optimizedHistory.map { msg in
            GeminiDirectRequestBody.Content(
                role: msg.role,
                parts: [GeminiDirectRequestBody.Part(text: msg.text)]
            )
        }
        
        return GeminiDirectRequestBody(
            system_instruction: GeminiDirectRequestBody.SystemInstruction(
                parts: [GeminiDirectRequestBody.SystemInstruction.Part(text: systemInstructionText)]
            ),
            contents: contents,
            generationConfig: GeminiDirectRequestBody.GenerationConfig(
                responseMimeType: "application/json",
                responseSchema: GeminiDirectRequestBody.ResponseSchema(
                    type: "OBJECT",
                    properties: GeminiDirectRequestBody.Properties(
                        reply: GeminiDirectRequestBody.Properties.Reply(type: "STRING"),
                        product_ids: GeminiDirectRequestBody.Properties.ProductIds(
                            type: "ARRAY",
                            items: GeminiDirectRequestBody.Properties.ProductIds.Items(type: "STRING")
                        )
                    ),
                    required: ["reply", "product_ids"]
                )
            )
        )
    }
}
