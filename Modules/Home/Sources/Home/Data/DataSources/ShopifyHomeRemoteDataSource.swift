@preconcurrency import MarktekNetworking

struct ShopifyHomeRemoteDataSource: HomeRemoteDataSource, Sendable {
    func fetchCollections(first: Int) async throws -> [CollectionDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetCollectionsQuery(first: first)
        )
        return data.collections.nodes.map { CollectionDataModel(node: $0) }
    }
}
