protocol ProductInfoRepository: Sendable {
    func fetchProduct(id: String) async throws -> ProductDetails
    func fetchProducts(productType: ProductType, first: Int, after: String?) async throws -> [ProductDetails]
}
