protocol GetProductComparisonRecommendationUseCaseProtocol: Sendable {
    func execute(
        currentProduct: ProductDetails,
        selectedProduct: ProductDetails,
        preference: String?
    ) async throws -> ProductComparisonRecommendation
}

struct GetProductComparisonRecommendationUseCase: GetProductComparisonRecommendationUseCaseProtocol {
    private let repository: any ProductComparisonRecommendationRepository

    init(repository: any ProductComparisonRecommendationRepository) {
        self.repository = repository
    }

    func execute(
        currentProduct: ProductDetails,
        selectedProduct: ProductDetails,
        preference: String?
    ) async throws -> ProductComparisonRecommendation {
        try await repository.recommend(
            currentProduct: currentProduct,
            selectedProduct: selectedProduct,
            preference: preference
        )
    }
}
