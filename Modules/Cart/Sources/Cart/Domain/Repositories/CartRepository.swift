protocol CartRepository: Sendable {
    func createCart(lines: [AddCartLineRequest]) async throws -> CartDetails
    func getCart(cartID: String) async throws -> CartDetails?
    func addLines(cartID: String, lines: [AddCartLineRequest]) async throws -> CartDetails
    func updateLines(cartID: String, lines: [UpdateCartLineRequest]) async throws -> CartDetails
    func removeLines(cartID: String, lineIDs: [String]) async throws -> CartDetails
    func applyDiscountCodes(cartID: String, discountCodes: [String]) async throws -> CartDetails
}
