enum CheckoutText {
    static let navigationTitle = "Payment"
    static let addressTitle = "Address"
    static let addressEmptyTitle = "No address selected"
    static let addressEmptyMessage = "Add a delivery address before placing your order."
    static let addressFailureTitle = "Address could not load"
    static let addressFailureFallbackMessage = "Try again in a moment."
    static let productsTitle = "Products"
    static let shippingMethodTitle = "Shipping Method"
    static let paymentMethodTitle = "Payment Method"
    static let orderSummaryTitle = "Order Summary"
    static let discountCodeTitle = "Discount Code"
    static let noDiscountCode = "No discount code"
    static let subtotalTitle = "Subtotal"
    static let shippingTitle = "Shipping"
    static let discountTitle = "Discount"
    static let totalTitle = "Total"
    static let checkoutButtonTitle = "Checkout Now"
    static let openingApplePayMessage = "Opening Apple Pay..."
    static let placingOrderMessage = "Placing your order..."
    static let checkoutErrorTitle = "Checkout unavailable"
    static let checkoutErrorDismissTitle = "OK"
    static let orderConfirmationNavigationTitle = "Order Confirmed"
    static let orderConfirmationTitle = "Order Confirmed"
    static let orderConfirmationMessage = "Thank you for your purchase. Your order was received successfully."
    static let orderConfirmationDetailsTitle = "Order Details"
    static let orderConfirmationDoneTitle = "Done"
    static let cartItemFallbackTitle = "Cart Item"
    static let cartItemImageAccessibilityLabel = "Cart item image"
    static let colorOptionName = "color"
    static let colourOptionName = "colour"
    static let defaultVariantName = "default"

    static func productsTitle(count: Int) -> String {
        "Products (\(count))"
    }

    static func colorText(_ value: String) -> String {
        "Color: \(value)"
    }

    static func quantityText(_ quantity: Int) -> String {
        "Qty: \(quantity)"
    }
}
