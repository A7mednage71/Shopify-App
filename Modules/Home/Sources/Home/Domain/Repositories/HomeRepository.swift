protocol HomeRepository: Sendable {
    func getCategories(first: Int) async throws -> [Collection]
    func getBrands(first: Int) async throws -> [Collection]
    func searchProducts(query: String) async throws -> [ShopProduct]
    func getProductsByVendor(vendor: String) async throws -> [ShopProduct]
    func getProductsByCategory(handle: String) async throws -> [ShopProduct]
    func getTrendingProducts(first: Int) async throws -> [HomeProduct]
    func getSpecialOffers(first: Int) async throws -> [HomeProduct]
}
