@preconcurrency import MarktekNetworking

struct ShopifyHomeRemoteDataSource: HomeRemoteDataSource, Sendable {
    
    func fetchCollections(first: Int) async throws -> [CollectionDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetCollectionsQuery(first: first)
        )
        return data.collections.nodes.map { CollectionDataModel(node: $0) }
    }

    func searchProducts(query: String, first: Int) async throws -> SearchResponseData {
        let response = try await ShopifyGraphQLClient.shared.fetch(
            SearchProductsQuery(query: query, first: first, after: .none)
        )
        return SearchResponseData(data: response)
    }

    func fetchTrendingProducts(first: Int) async throws -> [HomeProductDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetTrendingProductsQuery(first: .some(first))
        )
        return data.products.nodes.map { (node: GetTrendingProductsQuery.Data.Products.Node) in
            HomeProductDataModel(trendingNode: node)
        }
    }

    func fetchSpecialOffers(first: Int) async throws -> [HomeProductDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetSpecialOffersQuery(first: .some(first))
        )
        return data.products.nodes.map { (node: GetSpecialOffersQuery.Data.Products.Node) in
            HomeProductDataModel(specialOfferNode: node)
        }
    }
}

