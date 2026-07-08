import Foundation

struct CustomerProfileRepositoryImpl: CustomerProfileRepository, Sendable {
    private let remoteDataSource: any CustomerProfileRemoteDataSource

    init(remoteDataSource: any CustomerProfileRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCustomerProfile() async throws -> CustomerProfile {
        try await remoteDataSource.getCustomerProfile().toDomain()
    }

    func updateCustomerProfile(_ input: CustomerProfileUpdateInput) async throws -> CustomerProfile {
        try await remoteDataSource.updateCustomerProfile(input).toDomain()
    }
}
