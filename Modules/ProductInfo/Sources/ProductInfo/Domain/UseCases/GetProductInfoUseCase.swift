protocol GetProductInfoUseCaseProtocol: Sendable {
    func execute(productID: String) async throws -> ProductDetails
}

struct GetProductInfoUseCase: GetProductInfoUseCaseProtocol {
    private let repository: any ProductInfoRepository

    init(repository: any ProductInfoRepository) {
        self.repository = repository
    }

    func execute(productID: String) async throws -> ProductDetails {
        try await repository.fetchProduct(id: productID)
    }
}
