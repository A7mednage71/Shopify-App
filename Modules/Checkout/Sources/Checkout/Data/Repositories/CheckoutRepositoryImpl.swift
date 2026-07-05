import Foundation

public struct CheckoutRepositoryImpl: CheckoutRepository, Sendable {
    private let remoteDataSource: CheckoutRemoteDataSource

    public init(remoteDataSource: CheckoutRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func createOrder(input: OrderCreateInput) async throws -> Order {
        let dataModel = try await remoteDataSource.createOrder(input: input)
        return dataModel.toDomain()
    }

    public func getCustomerDetails() async throws -> CustomerDetails {
        let dataModel = try await remoteDataSource.getCustomerDetails()
        return dataModel.toDomain()
    }
}
