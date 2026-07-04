@preconcurrency import MarktekNetworking

extension CompletedOrderDataModel {
    init(gqlDraftOrder: CompleteDraftOrderMutation.Data.DraftOrderComplete.DraftOrder) {
        self.id = gqlDraftOrder.id
        self.status = gqlDraftOrder.status.rawValue
        
        if let gqlOrder = gqlDraftOrder.order {
            self.orderId = gqlOrder.id
            self.orderName = gqlOrder.name
            self.createdAt = gqlOrder.createdAt
            self.totalAmount = gqlOrder.totalPriceSet.shopMoney.amount
            self.currencyCode = gqlOrder.totalPriceSet.shopMoney.currencyCode.rawValue
            self.email = gqlOrder.email
        } else {
            self.orderId = nil
            self.orderName = nil
            self.createdAt = nil
            self.totalAmount = nil
            self.currencyCode = nil
            self.email = nil
        }
    }
}
