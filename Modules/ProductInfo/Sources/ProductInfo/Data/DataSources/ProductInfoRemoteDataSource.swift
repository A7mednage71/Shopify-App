protocol ProductInfoRemoteDataSource {
    func fetchProduct(id: String) async throws -> ProductInfoDataModel
}
