import Foundation

protocol GetSpecialOffersUseCaseProtocol: Sendable {
    func execute(first: Int) async throws -> [OfferProduct]
}

struct GetSpecialOffersUseCase: GetSpecialOffersUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(first: Int = 10) async throws -> [OfferProduct] {
        try await repository.getSpecialOffers(first: first)
    }
}
