struct HomeRepositoryImpl: HomeRepository, Sendable {
    private let remoteDataSource: any HomeRemoteDataSource

    init(remoteDataSource: any HomeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCollections(first: Int) async throws -> [Collection] {
        try await remoteDataSource.fetchCollections(first: first).map { $0.toDomain() }
    }
}
