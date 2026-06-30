protocol CartManager: Sendable {
    var cartID: String? { get }

    func save(cartID: String)
    func clearCartID()
}
