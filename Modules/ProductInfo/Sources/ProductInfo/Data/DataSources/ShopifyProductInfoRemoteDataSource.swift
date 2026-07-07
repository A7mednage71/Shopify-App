@preconcurrency import MarktekNetworking

struct ShopifyProductInfoRemoteDataSource: ProductInfoRemoteDataSource, Sendable {
    func fetchProduct(id: String) async throws -> ProductInfoDataModel {
        let data = try await ShopifyGraphQLClient.shared.fetch(GetProductQuery(id: id))

        guard let product = data.product else {
            throw ProductInfoRemoteDataSourceError.productNotFound
        }

        return ProductInfoDataModel(product: product)
    }

    func fetchProducts(productType: ProductType, first: Int, after: String?) async throws -> [ProductInfoDataModel] {
        guard let queryValue = productType.queryValue else { return [] }

        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetProductsByProductTypeQuery(
                productType: queryValue,
                first: .some(first),
                after: after.map { .some($0) } ?? .none
            )
        )

        return data.products.edges.map { ProductInfoDataModel(productTypeNode: $0.node) }
    }
}
