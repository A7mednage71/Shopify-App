import Foundation


public struct DraftOrderDataModel: Equatable, Sendable {
    public let id: String
    public let name: String
    public let status: String
    public let subtotalPrice: String?
    public let totalPrice: String?
    public let totalTax: String?
    public let currencyCode: String
    public let lineItems: [DraftOrderLineItemDataModel]
    public let appliedDiscount: AppliedDiscountDataModel?

    public init(
        id: String,
        name: String,
        status: String,
        subtotalPrice: String?,
        totalPrice: String?,
        totalTax: String?,
        currencyCode: String,
        lineItems: [DraftOrderLineItemDataModel],
        appliedDiscount: AppliedDiscountDataModel? = nil
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.subtotalPrice = subtotalPrice
        self.totalPrice = totalPrice
        self.totalTax = totalTax
        self.currencyCode = currencyCode
        self.lineItems = lineItems
        self.appliedDiscount = appliedDiscount
    }
}
