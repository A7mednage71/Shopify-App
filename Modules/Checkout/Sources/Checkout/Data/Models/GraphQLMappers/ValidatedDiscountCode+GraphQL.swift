import Foundation
import MarktekNetworking

extension ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode {
    func toDomain(code: String) -> ValidatedDiscountCode? {
        if let basicDiscount = codeDiscount.asDiscountCodeBasic {
            return basicDiscount.toDomain(code: code)
        }

        if let freeShippingDiscount = codeDiscount.asDiscountCodeFreeShipping {
            return freeShippingDiscount.toDomain(code: code)
        }

        return nil
    }
}

private extension ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic {
    func toDomain(code: String) -> ValidatedDiscountCode? {
        let value = customerGets.value

        let discountValue: ValidatedDiscountValue
        if let percentage = value.asDiscountPercentage {
            discountValue = .percentage(percentage.percentage)
        } else if let amount = value.asDiscountAmount,
                  let decimalAmount = Foundation.Decimal(string: amount.amount.amount) {
            discountValue = .fixedAmount(
                amount: decimalAmount,
                currencyCode: amount.amount.currencyCode.rawValue,
                appliesOnEachItem: amount.appliesOnEachItem
            )
        } else {
            return nil
        }

        return ValidatedDiscountCode(
            code: title,
            title: title,
            status: status.rawValue,
            startsAt: startsAt.checkoutDateValue,
            endsAt: endsAt?.checkoutDateValue,
            usageLimit: usageLimit,
            usageCount: asyncUsageCount,
            value: discountValue,
            minimumRequirement: minimumRequirement?.toDomain(),
            appliesToAllItems: customerGets.items.asAllDiscountItems?.allItems == true
        )
    }
}

private extension ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping {
    func toDomain(code: String) -> ValidatedDiscountCode? {
        let maximumAmount = maximumShippingPrice.flatMap { Foundation.Decimal(string: $0.amount) }
        let currencyCode = maximumShippingPrice?.currencyCode.rawValue

        return ValidatedDiscountCode(
            code: title,
            title: title,
            status: status.rawValue,
            startsAt: startsAt.checkoutDateValue,
            endsAt: endsAt?.checkoutDateValue,
            usageLimit: usageLimit,
            usageCount: asyncUsageCount,
            value: .freeShipping(
                maximumShippingPrice: maximumAmount,
                currencyCode: currencyCode
            ),
            minimumRequirement: minimumRequirement?.toDomain(),
            appliesToAllItems: true
        )
    }
}

private extension ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeBasic.MinimumRequirement {
    func toDomain() -> DiscountMinimumRequirement? {
        if let quantity = asDiscountMinimumQuantity,
           let minimumQuantity = Int(quantity.greaterThanOrEqualToQuantity) {
            return .quantity(minimumQuantity)
        }

        if let subtotal = asDiscountMinimumSubtotal,
           let amount = Foundation.Decimal(string: subtotal.greaterThanOrEqualToSubtotal.amount) {
            return .subtotal(
                amount: amount,
                currencyCode: subtotal.greaterThanOrEqualToSubtotal.currencyCode.rawValue
            )
        }

        return nil
    }
}

private extension ValidateDiscountCodeQuery.Data.CodeDiscountNodeByCode.CodeDiscount.AsDiscountCodeFreeShipping.MinimumRequirement {
    func toDomain() -> DiscountMinimumRequirement? {
        if let quantity = asDiscountMinimumQuantity,
           let minimumQuantity = Int(quantity.greaterThanOrEqualToQuantity) {
            return .quantity(minimumQuantity)
        }

        if let subtotal = asDiscountMinimumSubtotal,
           let amount = Foundation.Decimal(string: subtotal.greaterThanOrEqualToSubtotal.amount) {
            return .subtotal(
                amount: amount,
                currencyCode: subtotal.greaterThanOrEqualToSubtotal.currencyCode.rawValue
            )
        }

        return nil
    }
}

private extension String {
    var checkoutDateValue: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = formatter.date(from: self) {
            return date
        }

        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: self)
    }
}
