@preconcurrency import MarktekNetworking

struct ShopifyProductInfoRemoteDataSource: ProductInfoRemoteDataSource, Sendable {
    func fetchProduct(id: String) async throws -> ProductInfoDataModel {
        let data = try await ShopifyGraphQLClient.shared.fetch(GetProductQuery(id: id))

        guard let product = data.product else {
            throw ProductInfoRemoteDataSourceError.productNotFound
        }

        return ProductInfoDataModel(product: product)
    }
}
