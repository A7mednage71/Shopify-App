import Common

protocol CheckoutPaymentAuthorizing: AnyObject {
    func authorizeApplePay(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        pricing: CheckoutPricing
    ) async throws
}
