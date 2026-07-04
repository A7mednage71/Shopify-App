@preconcurrency import MarktekNetworking

extension DraftOrderDataModel {
    
    init(gqlDraftOrder: CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder) {
        self.id = gqlDraftOrder.id
        self.name = gqlDraftOrder.name
        self.status = gqlDraftOrder.status.rawValue
        self.subtotalPrice = gqlDraftOrder.subtotalPrice
        self.totalPrice = gqlDraftOrder.totalPrice
        self.totalTax = gqlDraftOrder.totalTax
        self.currencyCode = gqlDraftOrder.currencyCode.rawValue
        self.lineItems = gqlDraftOrder.lineItems.edges.map { DraftOrderLineItemDataModel(gqlLineItem: $0.node) }
        self.appliedDiscount = nil
    }

    init(gqlDraftOrder: ApplyDiscountMutation.Data.DraftOrderUpdate.DraftOrder) {
        self.id = gqlDraftOrder.id
        self.name = ""
        self.status = ""
        self.subtotalPrice = gqlDraftOrder.subtotalPrice
        self.totalPrice = gqlDraftOrder.totalPrice
        self.totalTax = nil
        self.currencyCode = gqlDraftOrder.appliedDiscount?.amountV2.currencyCode.rawValue ?? ""
        self.lineItems = []
        
        self.appliedDiscount = gqlDraftOrder.appliedDiscount.map { gqlDiscount in
            AppliedDiscountDataModel(
                title: gqlDiscount.title,
                value: gqlDiscount.value,
                valueType: gqlDiscount.valueType.rawValue,
                amount: gqlDiscount.amountV2.amount,
                currencyCode: gqlDiscount.amountV2.currencyCode.rawValue
            )
        }
    }
}
