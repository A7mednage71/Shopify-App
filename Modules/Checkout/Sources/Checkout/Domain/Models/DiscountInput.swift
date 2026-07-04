import Foundation

public struct DiscountInput: Equatable, Sendable {
    public enum ValueType: String, Sendable {
        case percentage = "PERCENTAGE"
        case fixedAmount = "FIXED_AMOUNT"
    }
    public let title: String
    public let valueType: ValueType
    public let value: Double

    public init(title: String, valueType: ValueType, value: Double) {
        self.title = title
        self.valueType = valueType
        self.value = value
    }
}
