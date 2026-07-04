import Foundation

extension DraftOrderVariantDataModel {
    public func toDomain() -> DraftOrder.LineItem.Variant {
        DraftOrder.LineItem.Variant(
            id: id,
            title: title,
            price: price,
            inventoryQuantity: inventoryQuantity,
            availableForSale: availableForSale
        )
    }
}
