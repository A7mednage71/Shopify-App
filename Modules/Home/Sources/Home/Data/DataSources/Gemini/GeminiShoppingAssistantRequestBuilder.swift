import Foundation

struct GeminiShoppingAssistantRequestBuilder {
    
    init() {}
    
    func buildSystemInstruction(catalog: [ShopProduct], brands: [Collection], categories: [Collection]) throws -> String {
        let aiProducts = catalog.map { $0.toAICatalogProduct() }
        let catalogJSONData = try JSONEncoder().encode(aiProducts)
        let catalogJSON = String(data: catalogJSONData, encoding: .utf8) ?? "[]"
        
        let aiBrands = brands.map { $0.toAICatalogCollection() }
        let brandsJSONData = try JSONEncoder().encode(aiBrands)
        let brandsJSON = String(data: brandsJSONData, encoding: .utf8) ?? "[]"
        
        let aiCategories = categories.map { $0.toAICatalogCollection() }
        let categoriesJSONData = try JSONEncoder().encode(aiCategories)
        let categoriesJSON = String(data: categoriesJSONData, encoding: .utf8) ?? "[]"
        
        return """
        You are a smart, professional shopping assistant for a Shopify sportswear shoe store.
        
        Here is the list of brand collections available in our store:
        \(brandsJSON)
        
        Here is the list of category collections available in our store:
        \(categoriesJSON)

        Here is the list of available products in our catalog. You must ONLY recommend products from this list:
        \(catalogJSON)

        Rules:
        - Respond in English. Be friendly, professional, and concise.
        - Recommend the closest matching 1-4 products from the catalog list by returning their exact 'productId's in the product_ids array.
        - If the user asks about available brands or categories, or if brand/category recommendations are relevant, return the corresponding collection 'id's in the 'brand_ids' or 'category_ids' arrays.
        - If no products/brands/categories match, tell the user politely.
        - Return the response strictly as a JSON object with this exact shape:
        {"reply": "your message here", "product_ids": ["p1", "p4"], "brand_ids": ["b1"], "category_ids": ["c1"]}
        If no products/brands/categories are relevant, return empty arrays [] for them.
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
    
    func buildRequestBody(messages: [ChatMessage], catalog: [ShopProduct], brands: [Collection], categories: [Collection]) throws -> GeminiDirectRequestBody {
        
        let systemInstructionText = try buildSystemInstruction(catalog: catalog, brands: brands, categories: categories)
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
                        ),
                        brand_ids: GeminiDirectRequestBody.Properties.BrandIds(
                            type: "ARRAY",
                            items: GeminiDirectRequestBody.Properties.BrandIds.Items(type: "STRING")
                        ),
                        category_ids: GeminiDirectRequestBody.Properties.CategoryIds(
                            type: "ARRAY",
                            items: GeminiDirectRequestBody.Properties.CategoryIds.Items(type: "STRING")
                        )
                    ),
                    required: ["reply", "product_ids", "brand_ids", "category_ids"]
                )
            )
        )
    }
}
