import Foundation

public struct DraftOrderCreateInput: Equatable, Sendable {
    public let lineItems: [LineItem]
    public let shippingAddress: CheckoutAddress?

    public init(lineItems: [LineItem], shippingAddress: CheckoutAddress? = nil) {
        self.lineItems = lineItems
        self.shippingAddress = shippingAddress
    }
}


public struct LineItem: Equatable, Sendable {
    public let variantId: String
    public let quantity: Int

    public init(variantId: String, quantity: Int) {
            self.variantId = variantId
            self.quantity = quantity
        }
    }