import Foundation

protocol GetProductsUseCaseProtocol: Sendable {
    func execute(first: Int) async throws -> [ShopProduct]
}

struct GetProductsUseCase: GetProductsUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(first: Int) async throws -> [ShopProduct] {
        try await repository.getProducts(first: first)
    }
}

