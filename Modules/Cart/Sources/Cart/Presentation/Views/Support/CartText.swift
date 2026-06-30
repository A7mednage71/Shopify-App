enum CartText {
    static let navigationTitle = "Cart"
    static let loadingAccessibilityLabel = "Loading cart"

    static let emptyImageName = "empty_cart"
    static let emptyTitle = "Your cart is empty"
    static let emptyMessage = "Looks like you have not added anything yet."
    static let startShoppingButtonTitle = "Start Shopping"

    static let checkoutButtonTitle = "Proceed to Checkout"
    static let orderSummaryTitle = "Order Summary"
    static let itemsSummaryTitle = "Items"
    static let subtotalSummaryTitle = "Subtotal"
    static let totalSummaryTitle = "Total"
    static let priceFallbackText = "$0"
    static let deleteActionTitle = "Delete"
    static let deleteAlertTitle = "Remove item?"
    static let deleteAlertConfirmTitle = "Remove"
    static let deleteAlertCancelTitle = "Cancel"

    static let failureTitle = "Cart could not load"
    static let failureRetryTitle = "Try Again"
    static let failureHelpMessage = "Check your connection and try again in a moment."
    static let failureFallbackMessage = "Something went wrong while fetching your cart."

    static let cartItemImageAccessibilityLabel = "Cart item image"
    static let cartItemFallbackTitle = "Cart Item"
    static let colorOptionName = "color"
    static let defaultVariantName = "default"

    static func optionText(name: String, value: String) -> String {
        "\(name): \(value)"
    }

    static func variantText(title: String) -> String {
        "Variant: \(title)"
    }

    static func deleteAlertMessage(itemTitle: String) -> String {
        "Remove \(itemTitle) from your cart?"
    }
}
