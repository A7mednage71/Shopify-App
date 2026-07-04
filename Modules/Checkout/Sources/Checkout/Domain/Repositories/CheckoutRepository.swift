import Foundation

public protocol CheckoutRepository: Sendable {
    func createDraftOrder(input: DraftOrderCreateInput) async throws -> DraftOrder
    func applyDraftOrderDiscount(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrder
}
