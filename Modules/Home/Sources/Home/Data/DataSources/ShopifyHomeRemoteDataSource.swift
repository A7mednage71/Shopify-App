@preconcurrency import MarktekNetworking

struct ShopifyHomeRemoteDataSource: HomeRemoteDataSource, Sendable {
    
    func fetchCollections(first: Int) async throws -> [CollectionDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetCollectionsQuery(first: first)
        )
        return data.collections.nodes.map { CollectionDataModel(node: $0) }
    }

    func searchProducts(query: String, first: Int) async throws -> [ProductDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            SearchProductsQuery(query: query, first: .some(first))
        )
        return data.search.nodes.compactMap { node in
            guard let product = node.asProduct else { return nil }
            return ProductDataModel(node: product)
        }
    }

    func fetchTrendingProducts(first: Int) async throws -> [ProductDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetTrendingProductsQuery(first: .some(first))
        )
        return data.products.nodes.map { (node: GetTrendingProductsQuery.Data.Products.Node) in
            ProductDataModel(node: node)
        }
    }
}

