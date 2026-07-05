protocol GetProductsByCategoryUseCaseProtocol: Sendable {
    func execute(handle: String) async throws -> [ShopProduct]
}

struct GetProductsByCategoryUseCase: GetProductsByCategoryUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(handle: String) async throws -> [ShopProduct] {
        try await repository.getProductsByCategory(handle: handle)
    }
}
