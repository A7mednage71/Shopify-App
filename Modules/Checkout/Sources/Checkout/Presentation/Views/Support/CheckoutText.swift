enum CheckoutText {
    static let navigationTitle = "Payment"
    static let addressTitle = "Address"
    static let addressEmptyTitle = "No address selected"
    static let addressEmptyMessage = "Add a delivery address before placing your order."
    static let addressFailureTitle = "Address could not load"
    static let addressFailureFallbackMessage = "Try again in a moment."
    static let productsTitle = "Products"
    static let paymentMethodTitle = "Payment Method"
    static let orderSummaryTitle = "Order Summary"
    static let discountCodeTitle = "Discount Code"
    static let noDiscountCode = "No discount code"
    static let subtotalTitle = "Subtotal"
    static let discountTitle = "Discount"
    static let totalTitle = "Total"
    static let checkoutButtonTitle = "Checkout Now"
    static let checkoutWebTitle = "Checkout"
    static let checkoutErrorTitle = "Checkout unavailable"
    static let checkoutErrorDismissTitle = "OK"
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
