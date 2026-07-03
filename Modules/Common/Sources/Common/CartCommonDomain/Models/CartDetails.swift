public struct CartDetails: Identifiable, Equatable, Sendable {
    public let id: String
    public let checkoutUrl: String?
    public let totalQuantity: Int
    public let discountCodes: [CartDiscountCode]
    public let cost: CartCost
    public let lines: [CartLine]
    public let isLocalEmpty: Bool

    public init(
        id: String,
        checkoutUrl: String?,
        totalQuantity: Int,
        discountCodes: [CartDiscountCode],
        cost: CartCost,
        lines: [CartLine],
        isLocalEmpty: Bool = false
    ) {
        self.id = id
        self.checkoutUrl = checkoutUrl
        self.totalQuantity = totalQuantity
        self.discountCodes = discountCodes
        self.cost = cost
        self.lines = lines
        self.isLocalEmpty = isLocalEmpty
    }

    public static let empty = CartDetails(
        id: "local-empty-cart",
        checkoutUrl: nil,
        totalQuantity: 0,
        discountCodes: [],
        cost: .zero,
        lines: [],
        isLocalEmpty: true
    )

    public var isEmpty: Bool {
        totalQuantity == 0 && lines.isEmpty
    }
}

public struct CartDiscountCode: Equatable, Sendable {
    public let code: String
    public let applicable: Bool

    public init(code: String, applicable: Bool) {
        self.code = code
        self.applicable = applicable
    }
}
