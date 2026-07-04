import Foundation

public struct CheckoutRepositoryImpl: CheckoutRepository, Sendable {
    private let remoteDataSource: CheckoutRemoteDataSource

    public init(remoteDataSource: CheckoutRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func createDraftOrder(input: DraftOrderCreateInput) async throws -> DraftOrder {
        let dataModel = try await remoteDataSource.createDraftOrder(input: input)
        return dataModel.toDomain()
    }

    public func applyDraftOrderDiscount(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrder {
        let dataModel = try await remoteDataSource.applyDraftOrderDiscount(draftOrderId: draftOrderId, discount: discount)
        return dataModel.toDomain()
    }

    public func completeDraftOrder(draftOrderId: String, paymentPending: Bool) async throws -> CompletedOrder {
        let dataModel = try await remoteDataSource.completeDraftOrder(draftOrderId: draftOrderId, paymentPending: paymentPending)
        return dataModel.toDomain()
    }
}
