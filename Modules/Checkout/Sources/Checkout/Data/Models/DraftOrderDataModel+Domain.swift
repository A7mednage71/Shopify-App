import Foundation

extension DraftOrderDataModel {
    public func toDomain() -> DraftOrder {
        let domainLineItems = lineItems.map { item -> DraftOrder.LineItem in
            let domainVariant: DraftOrder.LineItem.Variant?
            if let variant = item.variant {
                domainVariant = DraftOrder.LineItem.Variant(
                    id: variant.id,
                    title: variant.title,
                    price: variant.price,
                    inventoryQuantity: variant.inventoryQuantity,
                    availableForSale: variant.availableForSale
                )
            } else {
                domainVariant = nil
            }

            return DraftOrder.LineItem(
                id: item.id,
                title: item.title,
                quantity: item.quantity,
                originalUnitPrice: item.originalUnitPrice,
                discountedUnitPrice: item.discountedUnitPrice,
                variant: domainVariant
            )
        }

        return DraftOrder(
            id: id,
            name: name,
            status: status,
            subtotalPrice: subtotalPrice,
            totalPrice: totalPrice,
            totalTax: totalTax,
            currencyCode: currencyCode,
            lineItems: domainLineItems
        )
    }
}
