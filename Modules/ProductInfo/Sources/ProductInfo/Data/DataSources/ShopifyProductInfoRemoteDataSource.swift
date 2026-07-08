@preconcurrency import MarktekNetworking

import Common

struct ShopifyProductInfoRemoteDataSource: ProductInfoRemoteDataSource, Sendable {
    private let localizationManager: LocalizationManager

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
    }

    func fetchProduct(id: String) async throws -> ProductInfoDataModel {
        let language: GraphQLEnum<LanguageCode> = localizationManager.currentLanguage == .en ? .case(.en) : .case(.ar)
        let data = try await ShopifyGraphQLClient.shared.fetch(GetProductQuery(id: id, language: .some(language)))

        guard let product = data.product else {
            throw ProductInfoRemoteDataSourceError.productNotFound
        }

        return ProductInfoDataModel(product: product)
    }

    func fetchProducts(productType: ProductType, first: Int, after: String?) async throws -> [ProductInfoDataModel] {
        guard let queryValue = productType.queryValue else { return [] }

        let language: GraphQLEnum<LanguageCode> = localizationManager.currentLanguage == .en ? .case(.en) : .case(.ar)
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetProductsByProductTypeQuery(
                productType: queryValue,
                first: .some(first),
                after: after.map { .some($0) } ?? .none,
                language: .some(language)
            )
        )

        return data.products.edges.map { ProductInfoDataModel(productTypeNode: $0.node) }
    }
}
