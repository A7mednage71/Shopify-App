protocol ProductInfoRemoteDataSource: Sendable {
    func fetchProduct(id: String) async throws -> ProductInfoDataModel
    func fetchProducts(productType: ProductType, first: Int, after: String?) async throws -> [ProductInfoDataModel]
}
