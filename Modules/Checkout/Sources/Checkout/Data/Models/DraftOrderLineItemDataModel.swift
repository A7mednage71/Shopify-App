import Foundation

public struct DraftOrderLineItemDataModel: Equatable, Sendable {
    public let id: String
    public let title: String
    public let quantity: Int
    public let originalUnitPrice: String
    public let discountedUnitPrice: String
    public let variant: DraftOrderVariantDataModel?

    public init(
        id: String,
        title: String,
        quantity: Int,
        originalUnitPrice: String,
        discountedUnitPrice: String,
        variant: DraftOrderVariantDataModel?
    ) {
        self.id = id
        self.title = title
        self.quantity = quantity
        self.originalUnitPrice = originalUnitPrice
        self.discountedUnitPrice = discountedUnitPrice
        self.variant = variant
    }
}
