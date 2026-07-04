import Foundation

protocol GetProductsByVendorUseCaseProtocol: Sendable {
    func execute(vendor: String) async throws -> [ShopProduct]
}

struct GetProductsByVendorUseCase: GetProductsByVendorUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(vendor: String) async throws -> [ShopProduct] {
        try await repository.getProductsByVendor(vendor: vendor)
    }
}
