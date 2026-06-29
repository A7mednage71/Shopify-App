protocol CartRepository: Sendable {
    func createCart(lines: [AddCartLineRequest]) async throws -> CartDetails
    func getCurrentCart() async throws -> CartDetails
    func addLines(lines: [AddCartLineRequest]) async throws -> CartDetails
    func updateLines(lines: [UpdateCartLineRequest]) async throws -> CartDetails
    func removeLines(lineIDs: [String]) async throws -> CartDetails
    func applyDiscountCodes(discountCodes: [String]) async throws -> CartDetails
}
