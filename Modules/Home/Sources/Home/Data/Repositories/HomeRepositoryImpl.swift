struct HomeRepositoryImpl: HomeRepository, Sendable {
    private let remoteDataSource: any HomeRemoteDataSource

    init(remoteDataSource: any HomeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCategories(first: Int) async throws -> [Collection] {
        try await remoteDataSource.fetchCategories(first: first).map { $0.toDomain() }
    }

    func getBrands(first: Int) async throws -> [Collection] {
        try await remoteDataSource.fetchBrands(first: first).map { $0.toDomain() }
    }

    func getProductsByCategory(handle: String) async throws -> [ShopProduct] {
        let response = try await remoteDataSource.fetchProductsByCategory(handle: handle, first: 20)
        return response.map { $0.toDomain() }
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

