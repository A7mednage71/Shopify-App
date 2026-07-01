protocol HomeRepository: Sendable {
    func getCollections(first: Int) async throws -> [Collection]
}
