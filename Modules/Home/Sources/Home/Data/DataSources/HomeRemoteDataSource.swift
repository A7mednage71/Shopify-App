protocol HomeRemoteDataSource: Sendable {
    func fetchCategories(first: Int) async throws -> [CollectionDataModel]
    func fetchBrands(first: Int) async throws -> [CollectionDataModel]
    func searchProducts(query: String, first: Int) async throws -> SearchResponseData
    func fetchProductsByVendor(query: String, first: Int) async throws -> [ShopProductNode]
    func fetchProductsByCategory(handle: String, first: Int) async throws -> [ShopProductNode]
    func fetchProducts(first: Int) async throws -> [ShopProductNode]
    func fetchTrendingProducts(first: Int) async throws -> [HomeProductDataModel]
    func fetchSpecialOffers(first: Int) async throws -> [HomeProductDataModel]
}
