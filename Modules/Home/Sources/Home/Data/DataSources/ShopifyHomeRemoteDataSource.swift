@preconcurrency import MarktekNetworking

import Common

struct ShopifyHomeRemoteDataSource: HomeRemoteDataSource, Sendable {
    private let localizationManager: LocalizationManager

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
    }

    private var currentLanguage: GraphQLEnum<LanguageCode> {
        localizationManager.currentLanguage == .en ? .case(.en) : .case(.ar)
    }
    
    func fetchCategories(first: Int) async throws -> [CollectionDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetCustomCollectionsQuery(first: first)
        )
        return data.collections.nodes.map { CollectionDataModel(customNode: $0) }
    }

    func fetchBrands(first: Int) async throws -> [CollectionDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetSmartCollectionsQuery(first: first)
        )
        return data.collections.nodes.map { CollectionDataModel(smartNode: $0) }
    }

    func fetchProductsByCategory(handle: String, first: Int) async throws -> [ShopProductNode] {
        let response = try await ShopifyGraphQLClient.shared.fetch(
            GetProductsByCollectionQuery(handle: handle, first: first, after: .none, language: .some(currentLanguage))
        )
        return response.collection?.products.edges.map { ShopProductNode(collectionNode: $0.node) } ?? []
    }

    func fetchProducts(first: Int) async throws -> [ShopProductNode] {
        let response = try await ShopifyGraphQLClient.shared.fetch(
            GetProductsQuery(first: first, after: .none, language: .some(currentLanguage))
        )
        return response.products.edges.map { ShopProductNode(productNode: $0.node) }
    }

    func searchProducts(query: String, first: Int) async throws -> SearchResponseData {
        let response = try await ShopifyGraphQLClient.shared.fetch(
            SearchProductsQuery(query: query, first: first, after: .none, language: .some(currentLanguage))
        )
        return SearchResponseData(data: response)
    }

    func fetchProductsByVendor(query: String, first: Int) async throws -> [ShopProductNode] {
        let response = try await ShopifyGraphQLClient.shared.fetch(
            GetProductsByVendorQuery(query: query, first: first, after: .none, language: .some(currentLanguage))
        )
        return response.products.edges.map { ShopProductNode(vendorNode: $0.node) }
    }

    func fetchTrendingProducts(first: Int) async throws -> [HomeProductDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetTrendingProductsQuery(first: .some(first), language: .some(currentLanguage))
        )
        return data.products.nodes.map { (node: GetTrendingProductsQuery.Data.Products.Node) in
            HomeProductDataModel(trendingNode: node)
        }
    }

    func fetchSpecialOffers(first: Int) async throws -> [HomeProductDataModel] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetSpecialOffersQuery(first: .some(first), language: .some(currentLanguage))
        )
        return data.products.nodes.map { (node: GetSpecialOffersQuery.Data.Products.Node) in
            HomeProductDataModel(specialOfferNode: node)
        }
    }
}

