protocol GetTrendingProductsUseCaseProtocol: Sendable {
    func execute(first: Int) async throws -> [Product]
}

struct GetTrendingProductsUseCase: GetTrendingProductsUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(first: Int = 10) async throws -> [Product] {
        try await repository.getTrendingProducts(first: first)
    }
}
