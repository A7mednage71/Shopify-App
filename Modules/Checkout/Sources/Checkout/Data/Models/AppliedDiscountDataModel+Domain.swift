import Foundation

extension AppliedDiscountDataModel {
    public func toDomain() -> AppliedDiscount {
        AppliedDiscount(
            title: title,
            value: value,
            valueType: valueType,
            amount: amount,
            currencyCode: currencyCode
        )
    }
}
