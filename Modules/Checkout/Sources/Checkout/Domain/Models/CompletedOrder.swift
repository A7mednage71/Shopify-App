import Foundation

public struct CompletedOrder: Equatable, Sendable {
    public let id: String
    public let status: String
    public let orderId: String?
    public let orderName: String?
    public let createdAt: String?
    public let totalAmount: String?
    public let currencyCode: String?
    public let email: String?

    public init(
        id: String,
        status: String,
        orderId: String?,
        orderName: String?,
        createdAt: String?,
        totalAmount: String?,
        currencyCode: String?,
        email: String?
    ) {
        self.id = id
        self.status = status
        self.orderId = orderId
        self.orderName = orderName
        self.createdAt = createdAt
        self.totalAmount = totalAmount
        self.currencyCode = currencyCode
        self.email = email
    }
}
