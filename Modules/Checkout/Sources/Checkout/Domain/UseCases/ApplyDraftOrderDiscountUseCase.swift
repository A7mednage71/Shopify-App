import Foundation

public protocol ApplyDraftOrderDiscountUseCaseProtocol: Sendable {
    func execute(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrder
}

public struct ApplyDraftOrderDiscountUseCase: ApplyDraftOrderDiscountUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository

    public init(repository: CheckoutRepository) {
        self.repository = repository
    }

    public func execute(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrder {
        return try await repository.applyDraftOrderDiscount(draftOrderId: draftOrderId, discount: discount)
    }
}
