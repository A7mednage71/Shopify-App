protocol SearchProductsUseCaseProtocol: Sendable {
    func execute(query: String) async throws -> [Product]
}

struct SearchProductsUseCase: SearchProductsUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [Product] {
        try await repository.searchProducts(query: query)
    }
}
