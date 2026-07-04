@preconcurrency import MarktekNetworking

extension DraftOrderVariantDataModel {
    init(gqlVariant: CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder.LineItems.Edge.Node.Variant) {
        self.id = gqlVariant.id
        self.title = gqlVariant.title
        self.price = gqlVariant.price
        self.inventoryQuantity = gqlVariant.inventoryQuantity ?? 0
        self.availableForSale = gqlVariant.availableForSale
    }
}
