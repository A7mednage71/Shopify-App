struct ProductInfoRepositoryImpl: ProductInfoRepository, Sendable {
    private let remoteDataSource: ProductInfoRemoteDataSource

    init(remoteDataSource: ProductInfoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchProduct(id: String) async throws -> ProductDetails {
        try await remoteDataSource.fetchProduct(id: id).toDomain()
    }

    func fetchProducts(productType: ProductType, first: Int, after: String?) async throws -> [ProductDetails] {
        try await remoteDataSource
            .fetchProducts(productType: productType, first: first, after: after)
            .map { $0.toDomain() }
    }
}
