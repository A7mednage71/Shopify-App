import Foundation

struct GeminiDirectRequestBody: Encodable, Sendable {
    struct SystemInstruction: Encodable, Sendable {
        struct Part: Encodable, Sendable {
            let text: String
        }
        let parts: [Part]
    }
    struct Content: Encodable, Sendable {
        let role: String
        let parts: [Part]
    }
    struct Part: Encodable, Sendable {
        let text: String
    }
    struct GenerationConfig: Encodable, Sendable {
        let responseMimeType: String
        let responseSchema: ResponseSchema
    }
    struct ResponseSchema: Encodable, Sendable {
        let type: String
        let properties: Properties
        let required: [String]
    }
    struct Properties: Encodable, Sendable {
        struct Reply: Encodable, Sendable {
            let type: String
        }
        struct ProductIds: Encodable, Sendable {
            let type: String
            struct Items: Encodable, Sendable {
                let type: String
            }
            let items: Items
        }
        struct BrandIds: Encodable, Sendable {
            let type: String
            struct Items: Encodable, Sendable {
                let type: String
            }
            let items: Items
        }
        struct CategoryIds: Encodable, Sendable {
            let type: String
            struct Items: Encodable, Sendable {
                let type: String
            }
            let items: Items
        }
        let reply: Reply
        let product_ids: ProductIds
        let brand_ids: BrandIds
        let category_ids: CategoryIds
    }
    let system_instruction: SystemInstruction
    let contents: [Content]
    let generationConfig: GenerationConfig
}

struct GeminiDirectResponse: Decodable, Sendable {
    struct Candidate: Decodable, Sendable {
        struct Content: Decodable, Sendable {
            struct Part: Decodable, Sendable {
                let text: String
            }
            let parts: [Part]
        }
        let content: Content
    }
    let candidates: [Candidate]
}
