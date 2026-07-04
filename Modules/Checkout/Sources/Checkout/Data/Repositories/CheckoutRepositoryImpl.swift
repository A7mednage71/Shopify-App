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
}
