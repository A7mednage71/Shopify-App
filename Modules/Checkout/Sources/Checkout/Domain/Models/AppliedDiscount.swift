import Foundation

public struct AppliedDiscount: Equatable, Sendable {
    public let title: String?
    public let value: Double
    public let valueType: String
    public let amount: String
    public let currencyCode: String

    public init(
        title: String?,
        value: Double,
        valueType: String,
        amount: String,
        currencyCode: String
    ) {
        self.title = title
        self.value = value
        self.valueType = valueType
        self.amount = amount
        self.currencyCode = currencyCode
    }
}
