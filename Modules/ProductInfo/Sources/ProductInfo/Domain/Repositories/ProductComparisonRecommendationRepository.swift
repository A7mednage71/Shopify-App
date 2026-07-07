protocol ProductComparisonRecommendationRepository: Sendable {
    func recommend(
        currentProduct: ProductDetails,
        selectedProduct: ProductDetails,
        preference: String?
    ) async throws -> ProductComparisonRecommendation
}
