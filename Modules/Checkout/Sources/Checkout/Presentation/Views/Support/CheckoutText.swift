import Common
enum CheckoutText {
    static var navigationTitle: String { L10n.Checkout.navigationTitle }
    static var addressTitle: String { L10n.Checkout.addressTitle }
    static var addressEmptyTitle: String { L10n.Checkout.addressEmptyTitle }
    static var addressEmptyMessage: String { L10n.Checkout.addressEmptyMessage }
    static var missingAddressToastMessage: String { L10n.Checkout.missingAddressToastMessage }
    static var addressFailureTitle: String { L10n.Checkout.addressFailureTitle }
    static var addressFailureFallbackMessage: String { L10n.Checkout.addressFailureFallbackMessage }
    static var productsTitle: String { L10n.Checkout.productsTitle }
    static var shippingMethodTitle: String { L10n.Checkout.shippingMethodTitle }
    static var paymentMethodTitle: String { L10n.Checkout.paymentMethodTitle }
    static var orderSummaryTitle: String { L10n.Checkout.orderSummaryTitle }
    static var discountCodeTitle: String { L10n.Checkout.discountCodeTitle }
    static var noDiscountCode: String { L10n.Checkout.noDiscountCode }
    static var subtotalTitle: String { L10n.Checkout.subtotalTitle }
    static var shippingTitle: String { L10n.Checkout.shippingTitle }
    static var discountTitle: String { L10n.Checkout.discountTitle }
    static var totalTitle: String { L10n.Checkout.totalTitle }
    static var checkoutButtonTitle: String { L10n.Checkout.checkoutButtonTitle }
    static var openingApplePayMessage: String { L10n.Checkout.openingApplePayMessage }
    static var placingOrderMessage: String { L10n.Checkout.placingOrderMessage }
    static var checkoutErrorTitle: String { L10n.Checkout.checkoutErrorTitle }
    static var checkoutErrorDismissTitle: String { L10n.Checkout.checkoutErrorDismissTitle }
    static var orderConfirmationNavigationTitle: String { L10n.Checkout.orderConfirmationNavigationTitle }
    static var orderConfirmationTitle: String { L10n.Checkout.orderConfirmationTitle }
    static var orderConfirmationMessage: String { L10n.Checkout.orderConfirmationMessage }
    static var orderConfirmationDetailsTitle: String { L10n.Checkout.orderConfirmationDetailsTitle }
    static var orderConfirmationDoneTitle: String { L10n.Checkout.orderConfirmationDoneTitle }
    static var reviewButtonTitle: String { L10n.Checkout.reviewButtonTitle }
    static var reviewedButtonTitle: String { L10n.Checkout.reviewedButtonTitle }
    static var reviewSheetTitle: String { L10n.Checkout.reviewSheetTitle }
    static var reviewRatingTitle: String { L10n.Checkout.reviewRatingTitle }
    static var reviewTitlePlaceholder: String { L10n.Checkout.reviewTitlePlaceholder }
    static var reviewBodyPlaceholder: String { L10n.Checkout.reviewBodyPlaceholder }
    static var submitReviewButtonTitle: String { L10n.Checkout.submitReviewButtonTitle }
    static var submittingReviewButtonTitle: String { L10n.Checkout.submittingReviewButtonTitle }
    static var reviewSubmittedMessage: String { L10n.Checkout.reviewSubmittedMessage }
    static var orderNameTitle: String { L10n.Checkout.orderNameTitle }
    static var financialStatusTitle: String { L10n.Checkout.financialStatusTitle }
    static var fulfillmentStatusTitle: String { L10n.Checkout.fulfillmentStatusTitle }
    static var orderEmailTitle: String { L10n.Checkout.orderEmailTitle }
    static var cartItemFallbackTitle: String { L10n.Checkout.cartItemFallbackTitle }
    static var cartItemImageAccessibilityLabel: String { L10n.Checkout.cartItemImageAccessibilityLabel }
    static var colorOptionName: String { L10n.Checkout.colorOptionName }
    static var colourOptionName: String { L10n.Checkout.colourOptionName }
    static var defaultVariantName: String { L10n.Checkout.defaultVariantName }

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
