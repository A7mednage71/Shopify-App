import Foundation

struct CheckoutPricing: Equatable, Sendable {
    let currencyCode: String
    let subtotal: Decimal
    let shippingMethod: CheckoutShippingMethod
    let discountState: CheckoutDiscountValidationState
    let discountAmount: Decimal
    let orderDiscount: OrderDiscountCodeInput?

    var shippingAmount: Decimal {
        shippingMethod.amount
    }

    var total: Decimal {
        max(0, subtotal + shippingAmount - discountAmount)
    }
}
