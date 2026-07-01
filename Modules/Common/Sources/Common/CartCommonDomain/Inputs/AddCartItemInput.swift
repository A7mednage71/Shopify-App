public struct AddCartItemInput: Equatable, Sendable {
    public let variantID: String
    public let quantity: Int
    public let availableQuantity: Int?

    public init(variantID: String, quantity: Int, availableQuantity: Int? = nil) {
        self.variantID = variantID
        self.quantity = quantity
        self.availableQuantity = availableQuantity
    }
}
