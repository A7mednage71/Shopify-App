struct CartRepositoryImpl: CartRepository, Sendable {
    private let remoteDataSource: any CartRemoteDataSource

    init(remoteDataSource: any CartRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func createCart(lines: [AddCartLineRequest]) async throws -> CartDetails {
        try await remoteDataSource.createCart(lines: lines).toDomain()
    }

    func getCart(cartID: String) async throws -> CartDetails? {
        try await remoteDataSource.getCart(cartID: cartID)?.toDomain()
    }

    func addLines(cartID: String, lines: [AddCartLineRequest]) async throws -> CartDetails {
        try await remoteDataSource.addLines(cartID: cartID, lines: lines).toDomain()
    }

    func updateLines(cartID: String, lines: [UpdateCartLineRequest]) async throws -> CartDetails {
        try await remoteDataSource.updateLines(cartID: cartID, lines: lines).toDomain()
    }

    func removeLines(cartID: String, lineIDs: [String]) async throws -> CartDetails {
        try await remoteDataSource.removeLines(cartID: cartID, lineIDs: lineIDs).toDomain()
    }

    func applyDiscountCodes(cartID: String, discountCodes: [String]) async throws -> CartDetails {
        try await remoteDataSource.applyDiscountCodes(cartID: cartID, discountCodes: discountCodes).toDomain()
    }
}
