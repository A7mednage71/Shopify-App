protocol SearchProductsUseCaseProtocol: Sendable {
    func execute(query: String) async throws -> [SearchProduct]
}

struct SearchProductsUseCase: SearchProductsUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [SearchProduct] {
        try await repository.searchProducts(query: query)
    }
}
