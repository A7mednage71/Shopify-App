import Foundation

public enum DraftOrderError: LocalizedError, Sendable {
    case userError([String])
    case unknown

    public var errorDescription: String? {
        switch self {
        case .userError(let messages):
            return messages.joined(separator: ", ")
        case .unknown:
            return "An unknown error occurred while creating the draft order."
        }
    }
}

public struct DraftOrder: Equatable, Sendable {
    public struct LineItem: Equatable, Sendable {
        public struct Variant: Equatable, Sendable {
            public let id: String
            public let title: String
            public let price: String
            public let inventoryQuantity: Int
            public let availableForSale: Bool

            public init(
                id: String,
                title: String,
                price: String,
                inventoryQuantity: Int,
                availableForSale: Bool
            ) {
                self.id = id
                self.title = title
                self.price = price
                self.inventoryQuantity = inventoryQuantity
                self.availableForSale = availableForSale
            }
        }

        public let id: String
        public let title: String
        public let quantity: Int
        public let originalUnitPrice: String
        public let discountedUnitPrice: String
        public let variant: Variant?

        public init(
            id: String,
            title: String,
            quantity: Int,
            originalUnitPrice: String,
            discountedUnitPrice: String,
            variant: Variant?
        ) {
            self.id = id
            self.title = title
            self.quantity = quantity
            self.originalUnitPrice = originalUnitPrice
            self.discountedUnitPrice = discountedUnitPrice
            self.variant = variant
        }
    }

    public let id: String
    public let name: String
    public let status: String
    public let subtotalPrice: String?
    public let totalPrice: String?
    public let totalTax: String?
    public let currencyCode: String
    public let lineItems: [LineItem]

    public init(
        id: String,
        name: String,
        status: String,
        subtotalPrice: String?,
        totalPrice: String?,
        totalTax: String?,
        currencyCode: String,
        lineItems: [LineItem]
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.subtotalPrice = subtotalPrice
        self.totalPrice = totalPrice
        self.totalTax = totalTax
        self.currencyCode = currencyCode
        self.lineItems = lineItems
    }
}
