import Foundation

public protocol CheckoutRepository: Sendable {
    func createDraftOrder(input: DraftOrderCreateInput) async throws -> DraftOrder
}
