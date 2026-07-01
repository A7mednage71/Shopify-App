struct HomeRepositoryImpl: HomeRepository, Sendable {
    private let remoteDataSource: any HomeRemoteDataSource

    init(remoteDataSource: any HomeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCollections(first: Int) async throws -> [Collection] {
        try await remoteDataSource.fetchCollections(first: first).map { $0.toDomain() }
    }

    func searchProducts(query: String) async throws -> [Product] {
        try await remoteDataSource.searchProducts(query: query, first: 20).map { $0.toDomain() }
    }

    func getTrendingProducts(first: Int) async throws -> [Product] {
        try await remoteDataSource.fetchTrendingProducts(first: first).map { $0.toDomain() }
    }
}

