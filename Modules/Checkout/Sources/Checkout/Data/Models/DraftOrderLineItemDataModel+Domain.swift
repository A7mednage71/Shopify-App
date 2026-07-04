import Foundation

extension DraftOrderLineItemDataModel {
    public func toDomain() -> DraftOrder.LineItem {
        DraftOrder.LineItem(
            id: id,
            title: title,
            quantity: quantity,
            originalUnitPrice: originalUnitPrice,
            discountedUnitPrice: discountedUnitPrice,
            variant: variant?.toDomain()
        )
    }
}
