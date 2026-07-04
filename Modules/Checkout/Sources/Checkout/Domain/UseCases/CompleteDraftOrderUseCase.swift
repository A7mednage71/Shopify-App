import Foundation

public protocol CompleteDraftOrderUseCaseProtocol: Sendable {
    func execute(draftOrderId: String, paymentPending: Bool) async throws -> CompletedOrder
}

/// WARNING: This is an educational POC (Proof of Concept) for demonstration/simulation purposes.
/// In a production scenario, you would normally integrate a payment gateway (e.g., Stripe, Adyen, Apple Pay SDK)
/// to authorize and capture the payment before or during the draft order completion.
/// Here, we simply complete the draft order on Shopify without a real payment transaction.
public struct CompleteDraftOrderUseCase: CompleteDraftOrderUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository

    public init(repository: CheckoutRepository) {
        self.repository = repository
    }

    public func execute(draftOrderId: String, paymentPending: Bool) async throws -> CompletedOrder {
        return try await repository.completeDraftOrder(draftOrderId: draftOrderId, paymentPending: paymentPending)
    }
}
