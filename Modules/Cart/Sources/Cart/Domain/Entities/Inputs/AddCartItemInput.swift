public struct AddCartItemInput: Equatable, Sendable {
    public let variantID: String
    public let quantity: Int

    public init(variantID: String, quantity: Int) {
        self.variantID = variantID
        self.quantity = quantity
    }
}
