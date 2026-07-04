import Foundation

extension CompletedOrderDataModel {
    public func toDomain() -> CompletedOrder {
        CompletedOrder(
            id: id,
            status: status,
            orderId: orderId,
            orderName: orderName,
            createdAt: createdAt,
            totalAmount: totalAmount,
            currencyCode: currencyCode,
            email: email
        )
    }
}
