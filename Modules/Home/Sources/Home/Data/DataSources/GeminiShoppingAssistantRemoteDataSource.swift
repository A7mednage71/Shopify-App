import Foundation

public struct GeminiShoppingAssistantRemoteDataSource: ShoppingAssistantRemoteDataSource {
    
    public init() {}
    
    private var geminiApiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String,
              !key.isEmpty else {
            return ""
        }
        return key
    }
    
    public func getReply(messages: [ChatMessage], catalog: [ShopProduct]) async throws -> AssistantReply {
        let aiProducts = catalog.map { $0.toAICatalogProduct() }
        let catalogJSONData = try JSONEncoder().encode(aiProducts)
        let catalogJSON = String(data: catalogJSONData, encoding: .utf8) ?? "[]"
        
        let systemInstructionText = """
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
        
        let optimizedHistory = getOptimizedHistory(from: messages)
        let contents = optimizedHistory.map { msg in
            GeminiDirectRequestBody.Content(
                role: msg.role,
                parts: [GeminiDirectRequestBody.Part(text: msg.text)]
            )
        }
        
        let body = GeminiDirectRequestBody(
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
        
        let key = geminiApiKey
        guard !key.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=\(key)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(GeminiDirectResponse.self, from: data)
        
        guard let rawJSONText = response.candidates.first?.content.parts.first?.text else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [], debugDescription: "No reply text from Gemini candidate"))
        }
        
        let cleanedJSONText = rawJSONText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let jsonData = cleanedJSONText.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Corrupted string encoding"))
        }
        
        return try JSONDecoder().decode(AssistantReply.self, from: jsonData)
    }
    
    // MARK: - History Optimization (Max 10 messages context)
    private func getOptimizedHistory(from messages: [ChatMessage]) -> [GeminiRequestMessage] {
        let maxContext = 10
        let recentMessages = messages.suffix(maxContext)
        return recentMessages.map { msg in
            GeminiRequestMessage(
                role: msg.role == .user ? "user" : "model",
                text: msg.text
            )
        }
    }
    
    // MARK: - Encodable / Decodable Gemini Schemas
    private struct GeminiDirectRequestBody: Encodable {
        struct SystemInstruction: Encodable {
            struct Part: Encodable {
                let text: String
            }
            let parts: [Part]
        }
        struct Content: Encodable {
            let role: String
            let parts: [Part]
        }
        struct Part: Encodable {
            let text: String
        }
        struct GenerationConfig: Encodable {
            let responseMimeType: String
            let responseSchema: ResponseSchema
        }
        struct ResponseSchema: Encodable {
            let type: String
            let properties: Properties
            let required: [String]
        }
        struct Properties: Encodable {
            struct Reply: Encodable {
                let type: String
            }
            struct ProductIds: Encodable {
                let type: String
                struct Items: Encodable {
                    let type: String
                }
                let items: Items
            }
            let reply: Reply
            let product_ids: ProductIds
        }
        let system_instruction: SystemInstruction
        let contents: [Content]
        let generationConfig: GenerationConfig
    }
    
    private struct GeminiDirectResponse: Decodable {
        struct Candidate: Decodable {
            struct Content: Decodable {
                struct Part: Decodable {
                    let text: String
                }
                let parts: [Part]
            }
            let content: Content
        }
        let candidates: [Candidate]
    }
}
