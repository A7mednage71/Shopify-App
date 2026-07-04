import Foundation

public protocol CheckoutRepository: Sendable {
    func createDraftOrder(input: DraftOrderCreateInput) async throws -> DraftOrder
    func applyDraftOrderDiscount(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrder
    func completeDraftOrder(draftOrderId: String, paymentPending: Bool) async throws -> CompletedOrder
}
