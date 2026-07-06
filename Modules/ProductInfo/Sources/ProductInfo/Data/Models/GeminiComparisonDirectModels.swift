import Foundation

struct GeminiComparisonDirectRequestBody: Encodable, Sendable {
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
        let properties: [String: SchemaProperty]
        let required: [String]
    }

    struct SchemaProperty: Encodable, Sendable {
        let type: String
        let items: SchemaArrayItem?
        let enumValues: [String]?

        enum CodingKeys: String, CodingKey {
            case type
            case items
            case enumValues = "enum"
        }

        init(type: String, items: SchemaArrayItem? = nil, enumValues: [String]? = nil) {
            self.type = type
            self.items = items
            self.enumValues = enumValues
        }
    }

    struct SchemaArrayItem: Encodable, Sendable {
        let type: String
    }

    let system_instruction: SystemInstruction
    let contents: [Content]
    let generationConfig: GenerationConfig
}

struct GeminiComparisonDirectResponse: Decodable, Sendable {
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

struct ProductComparisonRecommendationDTO: Codable, Sendable {
    let recommendedProductID: String
    let confidence: ProductComparisonRecommendation.Confidence
    let headline: String
    let explanation: String
    let keyReasons: [String]
    let priceNote: String

    enum CodingKeys: String, CodingKey {
        case recommendedProductID = "recommended_product_id"
        case confidence
        case headline
        case explanation
        case keyReasons = "key_reasons"
        case priceNote = "price_note"
    }

    func toDomain() -> ProductComparisonRecommendation {
        ProductComparisonRecommendation(
            recommendedProductID: recommendedProductID,
            confidence: confidence,
            headline: headline.trimmedLimited(to: 70),
            explanation: explanation.trimmedLimited(to: 220),
            keyReasons: Array(keyReasons.prefix(3)).map { $0.trimmedLimited(to: 80) },
            priceNote: priceNote.trimmedLimited(to: 110)
        )
    }
}

private extension String {
    func trimmedLimited(to maxLength: Int) -> String {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count > maxLength else { return trimmed }

        let endIndex = trimmed.index(trimmed.startIndex, offsetBy: maxLength)
        return String(trimmed[..<endIndex]).trimmingCharacters(in: .whitespacesAndNewlines) + "..."
    }
}
