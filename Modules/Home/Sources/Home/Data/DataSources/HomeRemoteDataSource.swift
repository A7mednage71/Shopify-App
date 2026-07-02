protocol HomeRemoteDataSource: Sendable {
    func fetchCollections(first: Int) async throws -> [CollectionDataModel]
    func searchProducts(query: String, first: Int) async throws -> SearchResponseData
    func fetchTrendingProducts(first: Int) async throws -> [TrendingProductDataModel]
}
