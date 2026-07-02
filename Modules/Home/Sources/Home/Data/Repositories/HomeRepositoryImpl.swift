struct HomeRepositoryImpl: HomeRepository, Sendable {
    private let remoteDataSource: any HomeRemoteDataSource

    init(remoteDataSource: any HomeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCollections(first: Int) async throws -> [Collection] {
        try await remoteDataSource.fetchCollections(first: first).map { $0.toDomain() }
    }

    func searchProducts(query: String) async throws -> [SearchProduct] {
        let response = try await remoteDataSource.searchProducts(query: query, first: 20)
        return response.data.search.edges.map { $0.node.toDomain() }
    }

    func getTrendingProducts(first: Int) async throws -> [HomeProduct] {
        try await remoteDataSource.fetchTrendingProducts(first: first).map { $0.toDomain() }
    }

    func getSpecialOffers(first: Int) async throws -> [HomeProduct] {
        try await remoteDataSource.fetchSpecialOffers(first: first).map { $0.toDomain() }
    }
}

