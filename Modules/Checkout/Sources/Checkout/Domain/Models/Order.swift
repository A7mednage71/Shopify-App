import Foundation

public struct Order: Equatable, Sendable {
    public let id: String
    public let name: String
    public let financialStatus: String
    public let fulfillmentStatus: String
    public let totalPrice: String
    public let currencyCode: String
    public let email: String?

    public init(
        id: String,
        name: String,
        financialStatus: String,
        fulfillmentStatus: String,
        totalPrice: String,
        currencyCode: String,
        email: String? = nil
    ) {
        self.id = id
        self.name = name
        self.financialStatus = financialStatus
        self.fulfillmentStatus = fulfillmentStatus
        self.totalPrice = totalPrice
        self.currencyCode = currencyCode
        self.email = email
    }
}
