protocol HomeRemoteDataSource: Sendable {
    func fetchCollections(first: Int) async throws -> [CollectionDataModel]
    func searchProducts(query: String, first: Int) async throws -> SearchResponseData
    func fetchProductsByVendor(query: String, first: Int) async throws -> [ShopProductNode]
    func fetchTrendingProducts(first: Int) async throws -> [HomeProductDataModel]
    func fetchSpecialOffers(first: Int) async throws -> [HomeProductDataModel]
}
