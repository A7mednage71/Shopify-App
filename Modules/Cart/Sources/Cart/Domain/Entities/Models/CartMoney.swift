public struct CartMoney: Equatable, Sendable {
    public let amount: String
    public let currencyCode: String

    public init(amount: String, currencyCode: String) {
        self.amount = amount
        self.currencyCode = currencyCode
    }

    public static let zero = CartMoney(amount: "0.0", currencyCode: "")
}

public struct CartCost: Equatable, Sendable {
    public let subtotalAmount: CartMoney
    public let totalAmount: CartMoney
    public let totalTaxAmount: CartMoney?
    public let checkoutChargeAmount: CartMoney?

    public init(
        subtotalAmount: CartMoney,
        totalAmount: CartMoney,
        totalTaxAmount: CartMoney?,
        checkoutChargeAmount: CartMoney?
    ) {
        self.subtotalAmount = subtotalAmount
        self.totalAmount = totalAmount
        self.totalTaxAmount = totalTaxAmount
        self.checkoutChargeAmount = checkoutChargeAmount
    }

    public static let zero = CartCost(
        subtotalAmount: .zero,
        totalAmount: .zero,
        totalTaxAmount: nil,
        checkoutChargeAmount: nil
    )
}
