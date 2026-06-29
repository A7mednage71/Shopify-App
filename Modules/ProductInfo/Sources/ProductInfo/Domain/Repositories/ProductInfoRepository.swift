protocol ProductInfoRepository: Sendable {
    func fetchProduct(id: String) async throws -> ProductDetails
}
