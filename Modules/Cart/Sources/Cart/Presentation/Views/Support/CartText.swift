import Common
enum CartText {
    static var navigationTitle: String { L10n.Cart.navigationTitle }
    static var loadingAccessibilityLabel: String { L10n.Cart.loadingAccessibilityLabel }

    static var emptyImageName: String { L10n.Cart.emptyImageName }
    static var emptyTitle: String { L10n.Cart.emptyTitle }
    static var emptyMessage: String { L10n.Cart.emptyMessage }
    static var startShoppingButtonTitle: String { L10n.Cart.startShoppingButtonTitle }

    static var checkoutButtonTitle: String { L10n.Cart.checkoutButtonTitle }
    static var orderSummaryTitle: String { L10n.Cart.orderSummaryTitle }
    static var itemsSummaryTitle: String { L10n.Cart.itemsSummaryTitle }
    static var subtotalSummaryTitle: String { L10n.Cart.subtotalSummaryTitle }
    static var discountSummaryTitle: String { L10n.Cart.discountSummaryTitle }
    static var totalSummaryTitle: String { L10n.Cart.totalSummaryTitle }
    static var priceFallbackText: String { L10n.Cart.priceFallbackText }
    static var discountCodePlaceholder: String { L10n.Cart.discountCodePlaceholder }
    static var discountCodeApplyTitle: String { L10n.Cart.discountCodeApplyTitle }
    static var discountCodeRemoveTitle: String { L10n.Cart.discountCodeRemoveTitle }
    static var discountCodeApplyingTitle: String { L10n.Cart.discountCodeApplyingTitle }
    static var discountCodeNotApplicableMessage: String { L10n.Cart.discountCodeNotApplicableMessage }
    static var deleteActionTitle: String { L10n.Cart.deleteActionTitle }
    static var deleteAlertTitle: String { L10n.Cart.deleteAlertTitle }
    static var deleteAlertConfirmTitle: String { L10n.Cart.deleteAlertConfirmTitle }
    static var deleteAlertCancelTitle: String { L10n.Cart.deleteAlertCancelTitle }

    static var failureTitle: String { L10n.Cart.failureTitle }
    static var failureRetryTitle: String { L10n.Cart.failureRetryTitle }
    static var failureHelpMessage: String { L10n.Cart.failureHelpMessage }
    static var failureFallbackMessage: String { L10n.Cart.failureFallbackMessage }

    static var cartItemImageAccessibilityLabel: String { L10n.Cart.cartItemImageAccessibilityLabel }
    static var cartItemFallbackTitle: String { L10n.Cart.cartItemFallbackTitle }
    static var colorOptionName: String { L10n.Cart.colorOptionName }
    static var colourOptionName: String { L10n.Cart.colourOptionName }
    static var sizeOptionName: String { L10n.Cart.sizeOptionName }
    static var defaultVariantName: String { L10n.Cart.defaultVariantName }
    static var variantLabel: String { L10n.Cart.variantLabel }

    static func optionText(name: String, value: String) -> String {
        L10n.Cart.optionText(name: name, value: value)
    }

    static func optionsText(_ options: [String]) -> String {
        options.joined(separator: " • ")
    }

    static func variantText(title: String) -> String {
        "\(variantLabel): \(title)"
    }

    static func deleteAlertMessage(itemTitle: String) -> String {
        L10n.Cart.deleteAlertMessage(itemTitle)
    }
}
