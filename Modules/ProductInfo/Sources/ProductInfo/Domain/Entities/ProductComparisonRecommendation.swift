import Foundation

public struct ProductComparisonRecommendation: Equatable, Sendable {
    public enum Confidence: String, Codable, Sendable {
        case low
        case medium
        case high
    }

    public let recommendedProductID: String
    public let confidence: Confidence
    public let headline: String
    public let explanation: String
    public let keyReasons: [String]
    public let priceNote: String

    public init(
        recommendedProductID: String,
        confidence: Confidence,
        headline: String,
        explanation: String,
        keyReasons: [String],
        priceNote: String
    ) {
        self.recommendedProductID = recommendedProductID
        self.confidence = confidence
        self.headline = headline
        self.explanation = explanation
        self.keyReasons = keyReasons
        self.priceNote = priceNote
    }
}
