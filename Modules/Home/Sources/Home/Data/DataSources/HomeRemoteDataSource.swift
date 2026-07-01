protocol HomeRemoteDataSource: Sendable {
    func fetchCollections(first: Int) async throws -> [CollectionDataModel]
    func searchProducts(query: String, first: Int) async throws -> [SearchResultDataModel]
}
