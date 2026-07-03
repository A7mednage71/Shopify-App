struct HomeRepositoryImpl: HomeRepository, Sendable {
    private let remoteDataSource: any HomeRemoteDataSource

    init(remoteDataSource: any HomeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCollections(first: Int) async throws -> [Collection] {
        try await remoteDataSource.fetchCollections(first: first).map { $0.toDomain() }
    }

    func searchProducts(query: String) async throws -> [ShopProduct] {
        let response = try await remoteDataSource.searchProducts(query: query, first: 20)
        return response.data.search.edges.map { $0.node.toDomain() }
    }

    func getProductsByVendor(vendor: String) async throws -> [ShopProduct] {
        // Shopify query filter format: 'vendor:VendorName'
        let response = try await remoteDataSource.fetchProductsByVendor(query: "vendor:\(vendor)", first: 20)
        return response.map { $0.toDomain() }
    }

    func getTrendingProducts(first: Int) async throws -> [HomeProduct] {
        try await remoteDataSource.fetchTrendingProducts(first: first).map { $0.toDomain() }
    }

    func getSpecialOffers(first: Int) async throws -> [HomeProduct] {
        try await remoteDataSource.fetchSpecialOffers(first: first).map { $0.toDomain() }
    }
}

