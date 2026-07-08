import Foundation

@available(iOS 14.0, *)
public extension L10n.Common {
    static var customerTokenMissing: String { LocalizationManager.shared.localizedString(for: "common_customer_token_missing") }
    static var customerTokenExpired: String { LocalizationManager.shared.localizedString(for: "common_customer_token_expired") }
}

@available(iOS 14.0, *)
public extension L10n.Auth {
    static var emailFieldLabel: String { LocalizationManager.shared.localizedString(for: "auth_email_field_label") }
    static var passwordFieldLabel: String { LocalizationManager.shared.localizedString(for: "auth_password_field_label") }
    static var fullNameFieldLabel: String { LocalizationManager.shared.localizedString(for: "auth_full_name_field_label") }
    static var usernameOrEmailFieldLabel: String { LocalizationManager.shared.localizedString(for: "auth_username_or_email_field_label") }
    static var confirmPasswordFieldLabel: String { LocalizationManager.shared.localizedString(for: "auth_confirm_password_field_label") }
    static var createAccountPrompt: String { LocalizationManager.shared.localizedString(for: "auth_create_account_prompt") }
    static var signUpAction: String { LocalizationManager.shared.localizedString(for: "auth_sign_up_action") }
    static var alreadyHaveAccountPrompt: String { LocalizationManager.shared.localizedString(for: "auth_already_have_account_prompt") }
    static var loginAction: String { LocalizationManager.shared.localizedString(for: "auth_login_action") }
    static var validationEmailEmpty: String { LocalizationManager.shared.localizedString(for: "auth_validation_email_empty") }
    static var validationEmailInvalid: String { LocalizationManager.shared.localizedString(for: "auth_validation_email_invalid") }
    static var validationPasswordEmpty: String { LocalizationManager.shared.localizedString(for: "auth_validation_password_empty") }
    static var validationPasswordMinLength: String { LocalizationManager.shared.localizedString(for: "auth_validation_password_min_length") }
    static var validationNameEmpty: String { LocalizationManager.shared.localizedString(for: "auth_validation_name_empty") }
    static var validationConfirmPasswordEmpty: String { LocalizationManager.shared.localizedString(for: "auth_validation_confirm_password_empty") }
    static var validationPasswordsMismatch: String { LocalizationManager.shared.localizedString(for: "auth_validation_passwords_mismatch") }
    static var errorTryAgainLater: String { LocalizationManager.shared.localizedString(for: "auth_error_try_again_later") }
    static var errorSomethingWentWrong: String { LocalizationManager.shared.localizedString(for: "auth_error_something_went_wrong") }
    static var errorInvalidCredentials: String { LocalizationManager.shared.localizedString(for: "auth_error_invalid_credentials") }
    static var errorUserNotFound: String { LocalizationManager.shared.localizedString(for: "auth_error_user_not_found") }
    static var errorEmailAlreadyRegistered: String { LocalizationManager.shared.localizedString(for: "auth_error_email_already_registered") }
    static var errorNetwork: String { LocalizationManager.shared.localizedString(for: "auth_error_network") }
    static var errorUnknown: String { LocalizationManager.shared.localizedString(for: "auth_error_unknown") }
}

@available(iOS 14.0, *)
public extension L10n.Address {
    static var loadingAddresses: String { LocalizationManager.shared.localizedString(for: "address_loading_addresses") }
    static var saveFailedMessage: String { LocalizationManager.shared.localizedString(for: "address_save_failed_message") }
    static var locating: String { LocalizationManager.shared.localizedString(for: "address_locating") }
    static var confirmLocation: String { LocalizationManager.shared.localizedString(for: "address_confirm_location") }
    static var defaultAddressUpdated: String { LocalizationManager.shared.localizedString(for: "address_default_address_updated") }

    static func removeAddressSuccess(_ addressLine: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "address_remove_address_success"), addressLine)
    }

    static func deleteAddressMessage(_ addressLine: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "address_delete_address_message"), addressLine)
    }
}

@available(iOS 14.0, *)
public extension L10n.Cart {
    static var errorMissingCartID: String { LocalizationManager.shared.localizedString(for: "cart_error_missing_cart_id") }
    static var errorStaleCart: String { LocalizationManager.shared.localizedString(for: "cart_error_stale_cart") }
    static var malformedCreatePayload: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_create_payload") }
    static var malformedCreateCart: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_create_cart") }
    static var malformedAddPayload: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_add_payload") }
    static var malformedAddCart: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_add_cart") }
    static var malformedUpdatePayload: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_update_payload") }
    static var malformedUpdateCart: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_update_cart") }
    static var malformedRemovePayload: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_remove_payload") }
    static var malformedRemoveCart: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_remove_cart") }
    static var malformedDiscountPayload: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_discount_payload") }
    static var malformedDiscountCart: String { LocalizationManager.shared.localizedString(for: "cart_error_malformed_discount_cart") }
    static var variantLabel: String { LocalizationManager.shared.localizedString(for: "cart_variant_label") }

    static func invalidQuantityMessage(_ quantity: Int) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "cart_error_invalid_quantity"), quantity)
    }

    static func quantityLimitExceededMessage(quantity: Int, maximumQuantity: Int) -> String {
        String(
            format: LocalizationManager.shared.localizedString(for: "cart_error_quantity_limit_exceeded"),
            maximumQuantity,
            quantity
        )
    }

    static func optionText(name: String, value: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "cart_option_text"), name, value)
    }

    static func deleteAlertMessage(_ itemTitle: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "cart_delete_alert_message"), itemTitle)
    }
}

@available(iOS 14.0, *)
public extension L10n.Checkout {
    static var errorMalformedDiscountCode: String { LocalizationManager.shared.localizedString(for: "checkout_error_malformed_discount_code") }
    static var errorMalformedReviewsMetafield: String { LocalizationManager.shared.localizedString(for: "checkout_error_malformed_reviews_metafield") }
    static var errorUnknown: String { LocalizationManager.shared.localizedString(for: "checkout_error_unknown") }
    static var errorApplePayUnavailable: String { LocalizationManager.shared.localizedString(for: "checkout_error_apple_pay_unavailable") }
    static var errorApplePayPresentationFailed: String { LocalizationManager.shared.localizedString(for: "checkout_error_apple_pay_presentation_failed") }
    static var errorApplePayMissingMerchantIdentifier: String { LocalizationManager.shared.localizedString(for: "checkout_error_apple_pay_missing_merchant_identifier") }
    static var errorUnsupportedPaymentMethod: String { LocalizationManager.shared.localizedString(for: "checkout_error_unsupported_payment_method") }
    static var errorEmptyCart: String { LocalizationManager.shared.localizedString(for: "checkout_error_empty_cart") }
    static var errorInvalidLineItem: String { LocalizationManager.shared.localizedString(for: "checkout_error_invalid_line_item") }
    static var errorMissingCurrency: String { LocalizationManager.shared.localizedString(for: "checkout_error_missing_currency") }
    static var errorInvalidRating: String { LocalizationManager.shared.localizedString(for: "checkout_error_invalid_rating") }
    static var errorMissingReviewTitle: String { LocalizationManager.shared.localizedString(for: "checkout_error_missing_review_title") }
    static var errorMissingReviewBody: String { LocalizationManager.shared.localizedString(for: "checkout_error_missing_review_body") }
    static var dismissAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "checkout_dismiss_accessibility_label") }
    static var addDeliveryAddressAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "checkout_add_delivery_address_accessibility_label") }
    static var changeDeliveryAddressAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "checkout_change_delivery_address_accessibility_label") }
    static var discountInactive: String { LocalizationManager.shared.localizedString(for: "checkout_discount_inactive") }
    static var discountInactiveYet: String { LocalizationManager.shared.localizedString(for: "checkout_discount_inactive_yet") }
    static var discountExpired: String { LocalizationManager.shared.localizedString(for: "checkout_discount_expired") }
    static var discountUsageLimitReached: String { LocalizationManager.shared.localizedString(for: "checkout_discount_usage_limit_reached") }
    static var discountCurrencyMismatch: String { LocalizationManager.shared.localizedString(for: "checkout_discount_currency_mismatch") }
    static var discountHigherSubtotalRequired: String { LocalizationManager.shared.localizedString(for: "checkout_discount_higher_subtotal_required") }
    static var discountSelectedProductsOnly: String { LocalizationManager.shared.localizedString(for: "checkout_discount_selected_products_only") }
    static var discountShippingMethodUnsupported: String { LocalizationManager.shared.localizedString(for: "checkout_discount_shipping_method_unsupported") }
    static var paymentMethodApplePayTitle: String { LocalizationManager.shared.localizedString(for: "checkout_payment_method_apple_pay_title") }
    static var paymentMethodCashOnDeliveryTitle: String { LocalizationManager.shared.localizedString(for: "checkout_payment_method_cash_on_delivery_title") }
    static var paymentMethodApplePaySubtitle: String { LocalizationManager.shared.localizedString(for: "checkout_payment_method_apple_pay_subtitle") }
    static var paymentMethodCashOnDeliverySubtitle: String { LocalizationManager.shared.localizedString(for: "checkout_payment_method_cash_on_delivery_subtitle") }
    static var shippingMethodStandardTitle: String { LocalizationManager.shared.localizedString(for: "checkout_shipping_method_standard_title") }
    static var shippingMethodExpressTitle: String { LocalizationManager.shared.localizedString(for: "checkout_shipping_method_express_title") }
    static var shippingMethodStandardEstimate: String { LocalizationManager.shared.localizedString(for: "checkout_shipping_method_standard_estimate") }
    static var shippingMethodExpressEstimate: String { LocalizationManager.shared.localizedString(for: "checkout_shipping_method_express_estimate") }

    static func errorInvalidMoneyAmount(_ amount: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "checkout_error_invalid_money_amount"), amount)
    }

    static func discountMinimumQuantity(_ minimumQuantity: Int) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "checkout_discount_minimum_quantity"), minimumQuantity)
    }
}

@available(iOS 14.0, *)
public extension L10n.Home {
    static var assistantOfflineError: String { LocalizationManager.shared.localizedString(for: "home_assistant_offline_error") }
    static var assistantTimeoutError: String { LocalizationManager.shared.localizedString(for: "home_assistant_timeout_error") }
    static var assistantConnectionError: String { LocalizationManager.shared.localizedString(for: "home_assistant_connection_error") }
    static var assistantProcessingError: String { LocalizationManager.shared.localizedString(for: "home_assistant_processing_error") }
    static var assistantUnexpectedError: String { LocalizationManager.shared.localizedString(for: "home_assistant_unexpected_error") }
    static var assistantSyncingCatalog: String { LocalizationManager.shared.localizedString(for: "home_assistant_syncing_catalog") }

    static func categoryBrowseDescription(_ categoryName: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "home_category_browse_description"), categoryName)
    }

    static func categoryEmptyDescription(_ categoryName: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "home_category_empty_description"), categoryName)
    }

    static func vendorBrowseDescription(_ vendorName: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "home_vendor_browse_description"), vendorName)
    }

    static var vendorEmptyDescription: String { LocalizationManager.shared.localizedString(for: "home_vendor_empty_description") }

    static func sizesLabel(_ sizes: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "home_sizes_label"), sizes)
    }
}

@available(iOS 14.0, *)
public extension L10n.Onboarding {
    static var skipAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "onboarding_skip_accessibility_label") }

    static func pageAccessibilityLabel(currentIndex: Int, totalCount: Int) -> String {
        String(
            format: LocalizationManager.shared.localizedString(for: "onboarding_page_accessibility_label"),
            currentIndex,
            totalCount
        )
    }
}

@available(iOS 14.0, *)
public extension L10n.Orders {
//    static var paid: String { LocalizationManager.shared.localizedString(for: "orders_paid") }
    static var notPaid: String { LocalizationManager.shared.localizedString(for: "orders_not_paid") }
    static var noDeliveryAddress: String { LocalizationManager.shared.localizedString(for: "orders_no_delivery_address") }
    static var noDiscountCodeValue: String { LocalizationManager.shared.localizedString(for: "orders_no_discount_code_value") }
    static var errorCustomerNotFound: String { LocalizationManager.shared.localizedString(for: "orders_error_customer_not_found") }
    static var errorUnknown: String { LocalizationManager.shared.localizedString(for: "orders_error_unknown") }
    static var statusPending: String { LocalizationManager.shared.localizedString(for: "orders_status_pending") }
    static var statusInProgress: String { LocalizationManager.shared.localizedString(for: "orders_status_in_progress") }
    static var statusDelivered: String { LocalizationManager.shared.localizedString(for: "orders_status_delivered") }
    static var paymentApplePay: String { LocalizationManager.shared.localizedString(for: "orders_payment_apple_pay") }
    static var paymentCashOnDelivery: String { LocalizationManager.shared.localizedString(for: "orders_payment_cash_on_delivery") }
    static var paymentCreditCard: String { LocalizationManager.shared.localizedString(for: "orders_payment_credit_card") }

    static func productsTitle(_ count: Int) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "orders_products_title"), count)
    }

    static func orderAccessibilityLabel(_ orderName: String, _ status: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "orders_order_accessibility_label"), orderName, status)
    }
}

@available(iOS 14.0, *)
public extension L10n.ProductInfo {
    static var customerFallbackName: String { LocalizationManager.shared.localizedString(for: "productinfo_customer_fallback_name") }
    static var compareMatchingCatalogItems: String { LocalizationManager.shared.localizedString(for: "productinfo_compare_matching_catalog_items") }
    static var noReviewsSummary: String { LocalizationManager.shared.localizedString(for: "productinfo_no_reviews_summary") }
    static var notSpecifiedValue: String { LocalizationManager.shared.localizedString(for: "productinfo_not_specified_value") }
    static var confidenceSuffix: String { LocalizationManager.shared.localizedString(for: "productinfo_confidence_suffix") }

    static func compareOtherItems(_ productType: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "productinfo_compare_other_items"), productType)
    }

    static func reviewsSummary(_ reviewCount: Int, rating: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "productinfo_reviews_summary"), rating, reviewCount)
    }

    static func compactReviewsSummary(_ reviewCount: Int, rating: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "productinfo_compact_reviews_summary"), rating, reviewCount)
    }

    static func stockQuantity(_ quantity: Int) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "productinfo_stock_quantity"), quantity)
    }

    static func addToCartAccessibilityLabel(_ productTitle: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "productinfo_add_to_cart_accessibility_label"), productTitle)
    }

    static func ratingOutOfFive(_ rating: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "productinfo_rating_out_of_five"), rating)
    }

    static func confidenceLabel(_ confidence: String) -> String {
        String(format: LocalizationManager.shared.localizedString(for: "productinfo_confidence_label"), confidence)
    }
}

@available(iOS 14.0, *)
public extension L10n.Settings {
    static var firstName: String { LocalizationManager.shared.localizedString(for: "settings_first_name") }
    static var lastName: String { LocalizationManager.shared.localizedString(for: "settings_last_name") }
    static var phone: String { LocalizationManager.shared.localizedString(for: "settings_phone") }
    static var enterFirstName: String { LocalizationManager.shared.localizedString(for: "settings_enter_first_name") }
    static var enterLastName: String { LocalizationManager.shared.localizedString(for: "settings_enter_last_name") }
    static var enterPhoneNumber: String { LocalizationManager.shared.localizedString(for: "settings_enter_phone_number") }
}
