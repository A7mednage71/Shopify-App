import Foundation

enum ProductComparisonGeminiResponseParserError: Error, Equatable {
    case missingText
    case invalidRecommendedProductID
}

struct ProductComparisonGeminiResponseParser {
    init() {}

    func parse(
        response: GeminiComparisonDirectResponse,
        validProductIDs: Set<String>
    ) throws -> ProductComparisonRecommendation {
        guard let rawJSONText = response.candidates.first?.content.parts.first?.text else {
            throw ProductComparisonGeminiResponseParserError.missingText
        }

        let cleanedJSONText = rawJSONText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let data = cleanedJSONText.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [], debugDescription: "Corrupted recommendation text")
            )
        }

        let dto = try JSONDecoder().decode(ProductComparisonRecommendationDTO.self, from: data)
        guard validProductIDs.contains(dto.recommendedProductID) else {
            throw ProductComparisonGeminiResponseParserError.invalidRecommendedProductID
        }

        return dto.toDomain()
    }
}
