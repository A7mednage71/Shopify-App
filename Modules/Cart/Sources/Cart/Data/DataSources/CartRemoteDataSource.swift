protocol CartRemoteDataSource: Sendable {
    func createCart(lines: [AddCartLineRequest]) async throws -> CartDataModel
    func getCart(cartID: String) async throws -> CartDataModel?
    func addLines(cartID: String, lines: [AddCartLineRequest]) async throws -> CartDataModel
    func updateLines(cartID: String, lines: [UpdateCartLineRequest]) async throws -> CartDataModel
    func removeLines(cartID: String, lineIDs: [String]) async throws -> CartDataModel
    func applyDiscountCodes(cartID: String, discountCodes: [String]) async throws -> CartDataModel
}
