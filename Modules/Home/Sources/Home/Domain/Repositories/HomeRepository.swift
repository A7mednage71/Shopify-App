protocol HomeRepository: Sendable {
    func getCollections(first: Int) async throws -> [Collection]
    func searchProducts(query: String) async throws -> [Product]
    func getTrendingProducts(first: Int) async throws -> [Product]
}
