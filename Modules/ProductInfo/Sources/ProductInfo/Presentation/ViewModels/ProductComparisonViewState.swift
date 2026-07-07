import Foundation

enum ProductComparisonCandidatesState: Equatable, Sendable {
    case idle
    case loading
    case loaded([ProductDetails])
    case empty
    case failure(String)
}

enum ProductComparisonRecommendationState: Equatable, Sendable {
    case idle
    case loading
    case success(ProductComparisonRecommendation)
    case failure(String)
}
