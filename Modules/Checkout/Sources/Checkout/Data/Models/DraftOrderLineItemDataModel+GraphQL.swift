@preconcurrency import MarktekNetworking

extension DraftOrderLineItemDataModel {
    init(gqlLineItem: CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder.LineItems.Edge.Node) {
        self.id = gqlLineItem.id
        self.title = gqlLineItem.title
        self.quantity = gqlLineItem.quantity
        self.originalUnitPrice = gqlLineItem.originalUnitPrice
        self.discountedUnitPrice = gqlLineItem.discountedUnitPrice
        self.variant = gqlLineItem.variant.map(DraftOrderVariantDataModel.init(gqlVariant:))
    }
}
