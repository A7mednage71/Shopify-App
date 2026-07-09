protocol GetComparableProductsUseCaseProtocol: Sendable {
    func execute(currentProduct: ProductDetails, first: Int) async throws -> [ProductDetails]
}

struct GetComparableProductsUseCase: GetComparableProductsUseCaseProtocol {
    private let repository: any ProductInfoRepository

    init(repository: any ProductInfoRepository) {
        self.repository = repository
    }

    func execute(currentProduct: ProductDetails, first: Int = 50) async throws -> [ProductDetails] {
        let productType = currentProduct.normalizedProductType
        guard productType.isComparable else { return [] }

        return try await repository
            .fetchProducts(productType: productType, first: first, after: nil)
            .filter { $0.id != currentProduct.id }
    }
}
