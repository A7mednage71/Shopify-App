import Foundation

public enum CheckoutDiscountValidationState: Equatable, Sendable {
    case none
    case applied(code: String)
    case notApplicable(code: String, message: String)
}

public enum ValidatedDiscountValue: Equatable, Sendable {
    case fixedAmount(amount: Decimal, currencyCode: String, appliesOnEachItem: Bool)
    case percentage(Double)
    case freeShipping(maximumShippingPrice: Decimal?, currencyCode: String?)
}

public enum DiscountMinimumRequirement: Equatable, Sendable {
    case quantity(Int)
    case subtotal(amount: Decimal, currencyCode: String)
}

public struct ValidatedDiscountCode: Equatable, Sendable {
    let code: String
    let title: String
    let status: String
    let startsAt: Date?
    let endsAt: Date?
    let usageLimit: Int?
    let usageCount: Int
    let value: ValidatedDiscountValue
    let minimumRequirement: DiscountMinimumRequirement?
    let appliesToAllItems: Bool

    var isUsageLimitReached: Bool {
        guard let usageLimit else { return false }
        return usageCount >= usageLimit
    }
}

public enum OrderDiscountCodeInput: Equatable, Sendable {
    case itemFixed(code: String, amount: Decimal, currencyCode: String)
    case itemPercentage(code: String, percentage: Double)
    case freeShipping(code: String)
}
