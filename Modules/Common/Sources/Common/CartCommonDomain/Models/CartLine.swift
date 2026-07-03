public struct CartLine: Identifiable, Equatable, Sendable {
    public let id: String
    public let quantity: Int
    public let cost: CartLineCost?
    public let variant: CartProductVariant?

    public init(
        id: String,
        quantity: Int,
        cost: CartLineCost?,
        variant: CartProductVariant?
    ) {
        self.id = id
        self.quantity = quantity
        self.cost = cost
        self.variant = variant
    }
}

public struct CartLineCost: Equatable, Sendable {
    public let totalAmount: CartMoney?
    public let amountPerQuantity: CartMoney?
    public let compareAtAmountPerQuantity: CartMoney?

    public init(
        totalAmount: CartMoney?,
        amountPerQuantity: CartMoney?,
        compareAtAmountPerQuantity: CartMoney?
    ) {
        self.totalAmount = totalAmount
        self.amountPerQuantity = amountPerQuantity
        self.compareAtAmountPerQuantity = compareAtAmountPerQuantity
    }
}
