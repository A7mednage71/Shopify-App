protocol HomeRemoteDataSource: Sendable {
    func fetchCollections(first: Int) async throws -> [CollectionDataModel]
}
