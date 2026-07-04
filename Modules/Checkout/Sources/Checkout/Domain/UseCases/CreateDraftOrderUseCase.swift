import Foundation

public protocol CreateDraftOrderUseCaseProtocol: Sendable {
    func execute(input: DraftOrderCreateInput) async throws -> DraftOrder
}

public struct CreateDraftOrderUseCase: CreateDraftOrderUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository

    public init(repository: CheckoutRepository) {
        self.repository = repository
    }

    public func execute(input: DraftOrderCreateInput) async throws -> DraftOrder {
        return try await repository.createDraftOrder(input: input)
    }
}
