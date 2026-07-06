import Foundation

struct GeminiDirectRequestBody: Encodable {
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

struct GeminiDirectResponse: Decodable {
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
