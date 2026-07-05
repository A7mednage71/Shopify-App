import Foundation

extension OrderDataModel {
    public func toDomain() -> Order {
        return Order(
            id: id,
            name: name,
            financialStatus: financialStatus,
            fulfillmentStatus: fulfillmentStatus,
            totalPrice: totalPrice,
            currencyCode: currencyCode,
            email: email
        )
    }
}
