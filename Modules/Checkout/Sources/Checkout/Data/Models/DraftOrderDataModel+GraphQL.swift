@preconcurrency import MarktekNetworking

extension DraftOrderDataModel {
    init(gqlDraftOrder: CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder) {
        let items = gqlDraftOrder.lineItems.edges.map { edge -> DraftOrderLineItemDataModel in
            let node = edge.node
            let variant: DraftOrderVariantDataModel?
            if let gqlVariant = node.variant {
                variant = DraftOrderVariantDataModel(
                    id: gqlVariant.id,
                    title: gqlVariant.title,
                    price: gqlVariant.price,
                    inventoryQuantity: gqlVariant.inventoryQuantity ?? 0,
                    availableForSale: gqlVariant.availableForSale
                )
            } else {
                variant = nil
            }

            return DraftOrderLineItemDataModel(
                id: node.id,
                title: node.title,
                quantity: node.quantity,
                originalUnitPrice: node.originalUnitPrice,
                discountedUnitPrice: node.discountedUnitPrice,
                variant: variant
            )
        }

        self.id = gqlDraftOrder.id
        self.name = gqlDraftOrder.name
        self.status = gqlDraftOrder.status.rawValue
        self.subtotalPrice = gqlDraftOrder.subtotalPrice
        self.totalPrice = gqlDraftOrder.totalPrice
        self.totalTax = gqlDraftOrder.totalTax
        self.currencyCode = gqlDraftOrder.currencyCode.rawValue
        self.lineItems = items
    }
}
