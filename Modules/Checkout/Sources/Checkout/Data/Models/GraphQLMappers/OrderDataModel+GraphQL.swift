import Foundation
import MarktekNetworking

extension OrderDataModel {
    public init(gqlOrder: CreateOrderMutation.Data.OrderCreate.Order) {
        self.id = gqlOrder.id
        self.name = gqlOrder.name
        self.financialStatus = gqlOrder.displayFinancialStatus?.rawValue ?? ""
        self.fulfillmentStatus = gqlOrder.displayFulfillmentStatus.rawValue
        self.totalPrice = gqlOrder.totalPriceSet.presentmentMoney.amount
        self.currencyCode = gqlOrder.totalPriceSet.presentmentMoney.currencyCode.rawValue
        self.email = nil
    }
}
