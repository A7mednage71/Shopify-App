protocol ProductInfoRemoteDataSource : Sendable{
    func fetchProduct(id: String) async throws -> ProductInfoDataModel
}
