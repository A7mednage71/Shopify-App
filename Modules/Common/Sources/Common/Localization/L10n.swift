import Foundation

@available(iOS 14.0, *)
public enum L10n {
    public enum Common {
        public static var appName: String { LocalizationManager.shared.localizedString(for: "app_name") }
        public static var somethingWentWrong: String { LocalizationManager.shared.localizedString(for: "common_something_went_wrong") }
        public static var tryAgain: String { LocalizationManager.shared.localizedString(for: "common_try_again") }
    }
    
    public enum Auth {
        public static var orContinueWith: String { LocalizationManager.shared.localizedString(for: "auth_or_continue_with") }
        public static var error: String { LocalizationManager.shared.localizedString(for: "auth_error") }
        public static var ok: String { LocalizationManager.shared.localizedString(for: "auth_ok") }
        public static var createAccountTitle: String { LocalizationManager.shared.localizedString(for: "auth_create_account_title") }
        public static var byClicking: String { LocalizationManager.shared.localizedString(for: "auth_by_clicking") }
        public static var register: String { LocalizationManager.shared.localizedString(for: "auth_register") }
        public static var agreePublicOffer: String { LocalizationManager.shared.localizedString(for: "auth_agree_public_offer") }
        public static var createAccount: String { LocalizationManager.shared.localizedString(for: "auth_create_account") }
        public static var welcomeBack: String { LocalizationManager.shared.localizedString(for: "auth_welcome_back") }
        public static var forgetPassword: String { LocalizationManager.shared.localizedString(for: "auth_forget_password") }
        public static var login: String { LocalizationManager.shared.localizedString(for: "auth_login") }
    }
    
    public enum Settings {
        public static var profile: String { LocalizationManager.shared.localizedString(for: "settings_profile") }
        public static var accountSettings: String { LocalizationManager.shared.localizedString(for: "settings_account_settings") }
        public static var profileInformation: String { LocalizationManager.shared.localizedString(for: "settings_profile_information") }
        public static var savedAddresses: String { LocalizationManager.shared.localizedString(for: "settings_saved_addresses") }
        public static var orderHistory: String { LocalizationManager.shared.localizedString(for: "settings_order_history") }
        
        public static var regionalPreferences: String { LocalizationManager.shared.localizedString(for: "settings_regional_preferences") }
        public static var languageTitle: String { LocalizationManager.shared.localizedString(for: "settings_language_title") }
        public static var currencyDisplay: String { LocalizationManager.shared.localizedString(for: "settings_currency_display") }
        
        public static var preferences: String { LocalizationManager.shared.localizedString(for: "settings_preferences") }
        public static var darkMode: String { LocalizationManager.shared.localizedString(for: "settings_dark_mode") }
        public static var systemDefault: String { LocalizationManager.shared.localizedString(for: "settings_system_default") }
        
        public static var signingOut: String { LocalizationManager.shared.localizedString(for: "settings_signing_out") }
        public static var signOut: String { LocalizationManager.shared.localizedString(for: "settings_sign_out") }
        public static var signOutConfirmTitle: String { LocalizationManager.shared.localizedString(for: "settings_sign_out_confirm_title") }
        public static var cancel: String { LocalizationManager.shared.localizedString(for: "settings_cancel") }
        public static var signOutConfirmMessage: String { LocalizationManager.shared.localizedString(for: "settings_sign_out_confirm_message") }
        public static var signOutErrorTitle: String { LocalizationManager.shared.localizedString(for: "settings_sign_out_error_title") }
        
        public static var languageChangeTitle: String { LocalizationManager.shared.localizedString(for: "settings_language_change_title") }
        public static var languageChangeMessage: String { LocalizationManager.shared.localizedString(for: "settings_language_change_message") }
        public static var languageChangeConfirm: String { LocalizationManager.shared.localizedString(for: "settings_language_change_confirm") }
        public static var ok: String { LocalizationManager.shared.localizedString(for: "settings_ok") }
        public static var tryAgain: String { LocalizationManager.shared.localizedString(for: "settings_try_again") }
        public static var profileInformationTitle: String { LocalizationManager.shared.localizedString(for: "settings_profile_information_title") }
        public static var profileSubtitle: String { LocalizationManager.shared.localizedString(for: "settings_profile_subtitle") }
//        public static var firstName: String { LocalizationManager.shared.localizedString(for: "settings_first_name") }
//        public static var enterFirstName: String { LocalizationManager.shared.localizedString(for: "settings_enter_first_name") }
//        public static var lastName: String { LocalizationManager.shared.localizedString(for: "settings_last_name") }
//        public static var enterLastName: String { LocalizationManager.shared.localizedString(for: "settings_enter_last_name") }
//        public static var phone: String { LocalizationManager.shared.localizedString(for: "settings_phone") }
//        public static var enterPhoneNumber: String { LocalizationManager.shared.localizedString(for: "settings_enter_phone_number") }
        public static var email: String { LocalizationManager.shared.localizedString(for: "settings_email") }
        public static var saveChanges: String { LocalizationManager.shared.localizedString(for: "settings_save_changes") }
        public static var personalInfo: String { LocalizationManager.shared.localizedString(for: "settings_personal_info") }
        public static var loadingProfile: String { LocalizationManager.shared.localizedString(for: "settings_loading_profile") }
        
        public static var profileUpdateErrorTitle: String { LocalizationManager.shared.localizedString(for: "settings_profile_update_error_title") }
        public static var pleaseTryAgain: String { LocalizationManager.shared.localizedString(for: "settings_please_try_again") }
        public static var currentDetails: String { LocalizationManager.shared.localizedString(for: "settings_current_details") }
        public static var name: String { LocalizationManager.shared.localizedString(for: "settings_name") }
        public static var customerSince: String { LocalizationManager.shared.localizedString(for: "settings_customer_since") }
        public static var editDetails: String { LocalizationManager.shared.localizedString(for: "settings_edit_details") }
        public static var editInformation: String { LocalizationManager.shared.localizedString(for: "settings_edit_information") }
        public static var saving: String { LocalizationManager.shared.localizedString(for: "settings_saving") }
    }
    
    public enum Home {
        public static var categoryCollection: String { LocalizationManager.shared.localizedString(for: "home_category_collection") }
        public static var noProductsFound: String { LocalizationManager.shared.localizedString(for: "home_no_products_found") }
        public static var searchNoResults: String { LocalizationManager.shared.localizedString(for: "home_search_no_results") }
        public static var searchTryDifferent: String { LocalizationManager.shared.localizedString(for: "home_search_try_different") }
        public static var filterReset: String { LocalizationManager.shared.localizedString(for: "home_filter_reset") }
        public static var filterTitle: String { LocalizationManager.shared.localizedString(for: "home_filter_title") }
        public static var filterInStockOnly: String { LocalizationManager.shared.localizedString(for: "home_filter_in_stock_only") }
        public static var filterHideSoldOut: String { LocalizationManager.shared.localizedString(for: "home_filter_hide_sold_out") }
        public static var filterApply: String { LocalizationManager.shared.localizedString(for: "home_filter_apply") }
        public static var assistantFailed: String { LocalizationManager.shared.localizedString(for: "home_assistant_failed") }
        public static var assistantSyncing: String { LocalizationManager.shared.localizedString(for: "home_assistant_syncing") }
        public static var assistantRetry: String { LocalizationManager.shared.localizedString(for: "home_assistant_retry") }
        public static var assistantTitle: String { LocalizationManager.shared.localizedString(for: "home_assistant_title") }
        public static var assistantLoading: String { LocalizationManager.shared.localizedString(for: "home_assistant_loading") }
        public static var assistantFailedToLoad: String { LocalizationManager.shared.localizedString(for: "home_assistant_failed_to_load") }
        public static var assistantActive: String { LocalizationManager.shared.localizedString(for: "home_assistant_active") }
        public static var assistantAIPowered: String { LocalizationManager.shared.localizedString(for: "home_assistant_ai_powered") }
        public static var assistantAIBadge: String { LocalizationManager.shared.localizedString(for: "home_assistant_ai_badge") }
        public static var assistantResend: String { LocalizationManager.shared.localizedString(for: "home_assistant_resend") }
        public static var assistantBrands: String { LocalizationManager.shared.localizedString(for: "home_assistant_brands") }
        public static var assistantCategories: String { LocalizationManager.shared.localizedString(for: "home_assistant_categories") }
        public static var noResultsFound: String { LocalizationManager.shared.localizedString(for: "home_no_results_found") }
        public static var noResultsHint: String { LocalizationManager.shared.localizedString(for: "home_no_results_hint") }
        public static var sortOrderBy: String { LocalizationManager.shared.localizedString(for: "home_sort_order_by") }
        public static var categoryCollectionLabel: String { LocalizationManager.shared.localizedString(for: "home_category_collection_label") }
        public static var officialVendorLabel: String { LocalizationManager.shared.localizedString(for: "home_official_vendor_label") }
        public static var filterBrands: String { LocalizationManager.shared.localizedString(for: "home_filter_brands") }
        public static var filterCategoryTypes: String { LocalizationManager.shared.localizedString(for: "home_filter_category_types") }
        public static var filterTags: String { LocalizationManager.shared.localizedString(for: "home_filter_tags") }
        public static var filterPriceRange: String { LocalizationManager.shared.localizedString(for: "home_filter_price_range") }
        public static var filterClear: String { LocalizationManager.shared.localizedString(for: "home_filter_clear") }
    }
    
    public enum Address {
        public static var savedAddresses: String { LocalizationManager.shared.localizedString(for: "address_saved_addresses") }
        public static var delete: String { LocalizationManager.shared.localizedString(for: "address_delete") }
        public static var cancel: String { LocalizationManager.shared.localizedString(for: "address_cancel") }
        public static var apply: String { LocalizationManager.shared.localizedString(for: "address_apply") }
        public static var noSaved: String { LocalizationManager.shared.localizedString(for: "address_no_saved") }
        public static var noSavedDesc: String { LocalizationManager.shared.localizedString(for: "address_no_saved_desc") }
        public static var addNew: String { LocalizationManager.shared.localizedString(for: "address_add_new") }
        public static var serverError: String { LocalizationManager.shared.localizedString(for: "address_server_error") }
        public static var serverErrorDesc: String { LocalizationManager.shared.localizedString(for: "address_server_error_desc") }
        public static var tryAgain: String { LocalizationManager.shared.localizedString(for: "address_try_again") }
        public static var retry: String { LocalizationManager.shared.localizedString(for: "address_retry") }
        public static var confirm: String { LocalizationManager.shared.localizedString(for: "address_confirm") }
        public static var addressField: String { LocalizationManager.shared.localizedString(for: "address_address") }
        public static var zipCode: String { LocalizationManager.shared.localizedString(for: "address_zip_code") }
        public static var country: String { LocalizationManager.shared.localizedString(for: "address_country") }
        public static var addBtn: String { LocalizationManager.shared.localizedString(for: "address_add_btn") }
        public static var saving: String { LocalizationManager.shared.localizedString(for: "address_saving") }
        public static var ok: String { LocalizationManager.shared.localizedString(for: "address_ok") }
        public static var done: String { LocalizationManager.shared.localizedString(for: "address_done") }
        public static var unavailableTitle: String { LocalizationManager.shared.localizedString(for: "address_unavailable_title") }
        public static var deleteAddressAlert: String { LocalizationManager.shared.localizedString(for: "address_delete_alert") }
        public static var searchPlaceholder: String { LocalizationManager.shared.localizedString(for: "address_search_placeholder") }
        public static var iOS16Required: String { LocalizationManager.shared.localizedString(for: "address_ios16_required") }
    }
    
    public enum Orders {
        public static var review: String { LocalizationManager.shared.localizedString(for: "orders_review") }
        public static var details: String { LocalizationManager.shared.localizedString(for: "orders_details") }
        public static var paymentMethod: String { LocalizationManager.shared.localizedString(for: "orders_payment_method") }
        public static var deliveryAddress: String { LocalizationManager.shared.localizedString(for: "orders_delivery_address") }
        public static var summary: String { LocalizationManager.shared.localizedString(for: "orders_summary") }
        public static var tapToView: String { LocalizationManager.shared.localizedString(for: "orders_tap_to_view") }
        public static var history: String { LocalizationManager.shared.localizedString(for: "orders_history") }
        public static var noOrders: String { LocalizationManager.shared.localizedString(for: "orders_no_orders") }
        public static var noOrdersDesc: String { LocalizationManager.shared.localizedString(for: "orders_no_orders_desc") }
        
        public static var colorDefault: String { LocalizationManager.shared.localizedString(for: "orders_color_default") }
        public static var orderName: String { LocalizationManager.shared.localizedString(for: "orders_order_name") }
        public static var paymentStatus: String { LocalizationManager.shared.localizedString(for: "orders_payment_status") }
        public static var fulfillmentStatus: String { LocalizationManager.shared.localizedString(for: "orders_fulfillment_status") }
        public static var total: String { LocalizationManager.shared.localizedString(for: "orders_total") }
        public static var discountCode: String { LocalizationManager.shared.localizedString(for: "orders_discount_code") }
        public static var subtotal: String { LocalizationManager.shared.localizedString(for: "orders_subtotal") }
        public static var shipping: String { LocalizationManager.shared.localizedString(for: "orders_shipping") }
        public static var discount: String { LocalizationManager.shared.localizedString(for: "orders_discount") }
        public static var tryAgain: String { LocalizationManager.shared.localizedString(for: "orders_try_again") }
    }
    
    public enum Fav {
        public static var cancel: String { LocalizationManager.shared.localizedString(for: "fav_cancel") }
        public static var remove: String { LocalizationManager.shared.localizedString(for: "fav_remove") }
        public static var noFavs: String { LocalizationManager.shared.localizedString(for: "fav_no_favs") }
        public static var noFavsDesc: String { LocalizationManager.shared.localizedString(for: "fav_no_favs_desc") }
        public static var myWishlist: String { LocalizationManager.shared.localizedString(for: "fav_my_wishlist") }
        public static var favorites: String { LocalizationManager.shared.localizedString(for: "fav_favorites") }
        public static var browseSaved: String { LocalizationManager.shared.localizedString(for: "fav_browse_saved") }
        public static var removeAlertTitle: String { LocalizationManager.shared.localizedString(for: "fav_remove_alert_title") }
        public static func removeAlertMessage(_ productName: String) -> String { 
            String(format: LocalizationManager.shared.localizedString(for: "fav_remove_alert_message"), productName)
        }
    }
    
    public enum Onboarding {
        public static var discoverTitle: String { LocalizationManager.shared.localizedString(for: "onboarding_discover_title") }
        public static var discoverDesc: String { LocalizationManager.shared.localizedString(for: "onboarding_discover_desc") }
        public static var favoritesTitle: String { LocalizationManager.shared.localizedString(for: "onboarding_favorites_title") }
        public static var favoritesDesc: String { LocalizationManager.shared.localizedString(for: "onboarding_favorites_desc") }
        public static var checkoutTitle: String { LocalizationManager.shared.localizedString(for: "onboarding_checkout_title") }
        public static var checkoutDesc: String { LocalizationManager.shared.localizedString(for: "onboarding_checkout_desc") }
        public static var skip: String { LocalizationManager.shared.localizedString(for: "onboarding_skip") }
        public static var next: String { LocalizationManager.shared.localizedString(for: "onboarding_next") }
        public static var startShopping: String { LocalizationManager.shared.localizedString(for: "onboarding_start_shopping") }
    }
    public enum Cart {
        public static var navigationTitle: String { LocalizationManager.shared.localizedString(for: "cart_navigationTitle") }
        public static var loadingAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "cart_loadingAccessibilityLabel") }
        public static var emptyImageName: String { LocalizationManager.shared.localizedString(for: "cart_emptyImageName") }
        public static var emptyTitle: String { LocalizationManager.shared.localizedString(for: "cart_emptyTitle") }
        public static var emptyMessage: String { LocalizationManager.shared.localizedString(for: "cart_emptyMessage") }
        public static var startShoppingButtonTitle: String { LocalizationManager.shared.localizedString(for: "cart_startShoppingButtonTitle") }
        public static var checkoutButtonTitle: String { LocalizationManager.shared.localizedString(for: "cart_checkoutButtonTitle") }
        public static var orderSummaryTitle: String { LocalizationManager.shared.localizedString(for: "cart_orderSummaryTitle") }
        public static var itemsSummaryTitle: String { LocalizationManager.shared.localizedString(for: "cart_itemsSummaryTitle") }
        public static var subtotalSummaryTitle: String { LocalizationManager.shared.localizedString(for: "cart_subtotalSummaryTitle") }
        public static var discountSummaryTitle: String { LocalizationManager.shared.localizedString(for: "cart_discountSummaryTitle") }
        public static var totalSummaryTitle: String { LocalizationManager.shared.localizedString(for: "cart_totalSummaryTitle") }
        public static var priceFallbackText: String { LocalizationManager.shared.localizedString(for: "cart_priceFallbackText") }
        public static var discountCodePlaceholder: String { LocalizationManager.shared.localizedString(for: "cart_discountCodePlaceholder") }
        public static var discountCodeApplyTitle: String { LocalizationManager.shared.localizedString(for: "cart_discountCodeApplyTitle") }
        public static var discountCodeRemoveTitle: String { LocalizationManager.shared.localizedString(for: "cart_discountCodeRemoveTitle") }
        public static var discountCodeApplyingTitle: String { LocalizationManager.shared.localizedString(for: "cart_discountCodeApplyingTitle") }
        public static var discountCodeNotApplicableMessage: String { LocalizationManager.shared.localizedString(for: "cart_discountCodeNotApplicableMessage") }
        public static var deleteActionTitle: String { LocalizationManager.shared.localizedString(for: "cart_deleteActionTitle") }
        public static var deleteAlertTitle: String { LocalizationManager.shared.localizedString(for: "cart_deleteAlertTitle") }
        public static var deleteAlertConfirmTitle: String { LocalizationManager.shared.localizedString(for: "cart_deleteAlertConfirmTitle") }
        public static var deleteAlertCancelTitle: String { LocalizationManager.shared.localizedString(for: "cart_deleteAlertCancelTitle") }
        public static var failureTitle: String { LocalizationManager.shared.localizedString(for: "cart_failureTitle") }
        public static var failureRetryTitle: String { LocalizationManager.shared.localizedString(for: "cart_failureRetryTitle") }
        public static var failureHelpMessage: String { LocalizationManager.shared.localizedString(for: "cart_failureHelpMessage") }
        public static var failureFallbackMessage: String { LocalizationManager.shared.localizedString(for: "cart_failureFallbackMessage") }
        public static var cartItemImageAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "cart_cartItemImageAccessibilityLabel") }
        public static var cartItemFallbackTitle: String { LocalizationManager.shared.localizedString(for: "cart_cartItemFallbackTitle") }
        public static var colorOptionName: String { LocalizationManager.shared.localizedString(for: "cart_colorOptionName") }
        public static var colourOptionName: String { LocalizationManager.shared.localizedString(for: "cart_colourOptionName") }
        public static var sizeOptionName: String { LocalizationManager.shared.localizedString(for: "cart_sizeOptionName") }
        public static var defaultVariantName: String { LocalizationManager.shared.localizedString(for: "cart_defaultVariantName") }
    }

    public enum ProductInfo {
        public static var productLoadFailureTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_productLoadFailureTitle") }
        public static var retryButtonTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_retryButtonTitle") }
        public static var retryAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "productinfo_retryAccessibilityLabel") }
        public static var failureHelpMessage: String { LocalizationManager.shared.localizedString(for: "productinfo_failureHelpMessage") }
        public static var failureFallbackMessage: String { LocalizationManager.shared.localizedString(for: "productinfo_failureFallbackMessage") }
        public static var loadingAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "productinfo_loadingAccessibilityLabel") }
        public static var productImageAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "productinfo_productImageAccessibilityLabel") }
        public static var selectAvailableVariantMessage: String { LocalizationManager.shared.localizedString(for: "productinfo_selectAvailableVariantMessage") }
        public static var viewCartAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "productinfo_viewCartAccessibilityLabel") }
        public static var removeFromFavoritesAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "productinfo_removeFromFavoritesAccessibilityLabel") }
        public static var addToFavoritesAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "productinfo_addToFavoritesAccessibilityLabel") }
        public static var noDescriptionAvailable: String { LocalizationManager.shared.localizedString(for: "productinfo_noDescriptionAvailable") }
        public static var descriptionTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_descriptionTitle") }
        public static var reviewsTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_reviewsTitle") }
        public static var compareProductsTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_compareProductsTitle") }
        public static var compareProductsSubtitle: String { LocalizationManager.shared.localizedString(for: "productinfo_compareProductsSubtitle") }
        public static var comparisonSheetTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_comparisonSheetTitle") }
        public static var closeButtonTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_closeButtonTitle") }
        public static var loadingComparableProducts: String { LocalizationManager.shared.localizedString(for: "productinfo_loadingComparableProducts") }
        public static var noComparableProductsTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_noComparableProductsTitle") }
        public static var noComparableProductsMessage: String { LocalizationManager.shared.localizedString(for: "productinfo_noComparableProductsMessage") }
        public static var comparisonLoadFailureTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_comparisonLoadFailureTitle") }
        public static var noSearchResultsTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_noSearchResultsTitle") }
        public static var noSearchResultsMessage: String { LocalizationManager.shared.localizedString(for: "productinfo_noSearchResultsMessage") }
        public static var changeComparisonProductTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_changeComparisonProductTitle") }
        public static var currentProductTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_currentProductTitle") }
        public static var selectedProductTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_selectedProductTitle") }
        public static var comparisonPreferenceTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_comparisonPreferenceTitle") }
        public static var comparisonPreferencePlaceholder: String { LocalizationManager.shared.localizedString(for: "productinfo_comparisonPreferencePlaceholder") }
        public static var getRecommendationButtonTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_getRecommendationButtonTitle") }
        public static var loadingRecommendation: String { LocalizationManager.shared.localizedString(for: "productinfo_loadingRecommendation") }
        public static var recommendationFailureTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_recommendationFailureTitle") }
        public static var viewRecommendedProductTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_viewRecommendedProductTitle") }
        public static var compareSimilarProductsTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_compareSimilarProductsTitle") }
        public static var comparisonSearchPlaceholder: String { LocalizationManager.shared.localizedString(for: "productinfo_comparisonSearchPlaceholder") }
        public static var stockFactTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_stockFactTitle") }
        public static var vendorFactTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_vendorFactTitle") }
        public static var materialFactTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_materialFactTitle") }
        public static var notSpecified: String { LocalizationManager.shared.localizedString(for: "productinfo_notSpecified") }
        public static var noReviewsYet: String { LocalizationManager.shared.localizedString(for: "productinfo_noReviewsYet") }
        public static var reviewEmptyMessage: String { LocalizationManager.shared.localizedString(for: "productinfo_reviewEmptyMessage") }
        public static var readLessButtonTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_readLessButtonTitle") }
        public static var readMoreButtonTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_readMoreButtonTitle") }
        public static var quantityTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_quantityTitle") }
        public static var totalTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_totalTitle") }
        public static var addingToCartButtonTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_addingToCartButtonTitle") }
        public static var addToCartButtonTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_addToCartButtonTitle") }
        public static var outOfStock: String { LocalizationManager.shared.localizedString(for: "productinfo_outOfStock") }
        public static var inStock: String { LocalizationManager.shared.localizedString(for: "productinfo_inStock") }
        public static var colorOptionName: String { LocalizationManager.shared.localizedString(for: "productinfo_colorOptionName") }
        public static var colourOptionName: String { LocalizationManager.shared.localizedString(for: "productinfo_colourOptionName") }
        public static var defaultTitleOptionName: String { LocalizationManager.shared.localizedString(for: "productinfo_defaultTitleOptionName") }
        public static var defaultVariantTitle: String { LocalizationManager.shared.localizedString(for: "productinfo_defaultVariantTitle") }
    }

    public enum Checkout {
        public static var navigationTitle: String { LocalizationManager.shared.localizedString(for: "checkout_navigationTitle") }
        public static var addressTitle: String { LocalizationManager.shared.localizedString(for: "checkout_addressTitle") }
        public static var addressEmptyTitle: String { LocalizationManager.shared.localizedString(for: "checkout_addressEmptyTitle") }
        public static var addressEmptyMessage: String { LocalizationManager.shared.localizedString(for: "checkout_addressEmptyMessage") }
        public static var missingAddressToastMessage: String { LocalizationManager.shared.localizedString(for: "checkout_missingAddressToastMessage") }
        public static var addressFailureTitle: String { LocalizationManager.shared.localizedString(for: "checkout_addressFailureTitle") }
        public static var addressFailureFallbackMessage: String { LocalizationManager.shared.localizedString(for: "checkout_addressFailureFallbackMessage") }
        public static var productsTitle: String { LocalizationManager.shared.localizedString(for: "checkout_productsTitle") }
        public static var shippingMethodTitle: String { LocalizationManager.shared.localizedString(for: "checkout_shippingMethodTitle") }
        public static var paymentMethodTitle: String { LocalizationManager.shared.localizedString(for: "checkout_paymentMethodTitle") }
        public static var orderSummaryTitle: String { LocalizationManager.shared.localizedString(for: "checkout_orderSummaryTitle") }
        public static var discountCodeTitle: String { LocalizationManager.shared.localizedString(for: "checkout_discountCodeTitle") }
        public static var noDiscountCode: String { LocalizationManager.shared.localizedString(for: "checkout_noDiscountCode") }
        public static var subtotalTitle: String { LocalizationManager.shared.localizedString(for: "checkout_subtotalTitle") }
        public static var shippingTitle: String { LocalizationManager.shared.localizedString(for: "checkout_shippingTitle") }
        public static var discountTitle: String { LocalizationManager.shared.localizedString(for: "checkout_discountTitle") }
        public static var totalTitle: String { LocalizationManager.shared.localizedString(for: "checkout_totalTitle") }
        public static var checkoutButtonTitle: String { LocalizationManager.shared.localizedString(for: "checkout_checkoutButtonTitle") }
        public static var openingApplePayMessage: String { LocalizationManager.shared.localizedString(for: "checkout_openingApplePayMessage") }
        public static var placingOrderMessage: String { LocalizationManager.shared.localizedString(for: "checkout_placingOrderMessage") }
        public static var checkoutErrorTitle: String { LocalizationManager.shared.localizedString(for: "checkout_checkoutErrorTitle") }
        public static var checkoutErrorDismissTitle: String { LocalizationManager.shared.localizedString(for: "checkout_checkoutErrorDismissTitle") }
        public static var orderConfirmationNavigationTitle: String { LocalizationManager.shared.localizedString(for: "checkout_orderConfirmationNavigationTitle") }
        public static var orderConfirmationTitle: String { LocalizationManager.shared.localizedString(for: "checkout_orderConfirmationTitle") }
        public static var orderConfirmationMessage: String { LocalizationManager.shared.localizedString(for: "checkout_orderConfirmationMessage") }
        public static var orderConfirmationDetailsTitle: String { LocalizationManager.shared.localizedString(for: "checkout_orderConfirmationDetailsTitle") }
        public static var orderConfirmationDoneTitle: String { LocalizationManager.shared.localizedString(for: "checkout_orderConfirmationDoneTitle") }
        public static var reviewButtonTitle: String { LocalizationManager.shared.localizedString(for: "checkout_reviewButtonTitle") }
        public static var reviewedButtonTitle: String { LocalizationManager.shared.localizedString(for: "checkout_reviewedButtonTitle") }
        public static var reviewSheetTitle: String { LocalizationManager.shared.localizedString(for: "checkout_reviewSheetTitle") }
        public static var reviewRatingTitle: String { LocalizationManager.shared.localizedString(for: "checkout_reviewRatingTitle") }
        public static var reviewTitlePlaceholder: String { LocalizationManager.shared.localizedString(for: "checkout_reviewTitlePlaceholder") }
        public static var reviewBodyPlaceholder: String { LocalizationManager.shared.localizedString(for: "checkout_reviewBodyPlaceholder") }
        public static var submitReviewButtonTitle: String { LocalizationManager.shared.localizedString(for: "checkout_submitReviewButtonTitle") }
        public static var submittingReviewButtonTitle: String { LocalizationManager.shared.localizedString(for: "checkout_submittingReviewButtonTitle") }
        public static var reviewSubmittedMessage: String { LocalizationManager.shared.localizedString(for: "checkout_reviewSubmittedMessage") }
        public static var orderNameTitle: String { LocalizationManager.shared.localizedString(for: "checkout_orderNameTitle") }
        public static var financialStatusTitle: String { LocalizationManager.shared.localizedString(for: "checkout_financialStatusTitle") }
        public static var fulfillmentStatusTitle: String { LocalizationManager.shared.localizedString(for: "checkout_fulfillmentStatusTitle") }
        public static var orderEmailTitle: String { LocalizationManager.shared.localizedString(for: "checkout_orderEmailTitle") }
        public static var cartItemFallbackTitle: String { LocalizationManager.shared.localizedString(for: "checkout_cartItemFallbackTitle") }
        public static var cartItemImageAccessibilityLabel: String { LocalizationManager.shared.localizedString(for: "checkout_cartItemImageAccessibilityLabel") }
        public static var colorOptionName: String { LocalizationManager.shared.localizedString(for: "checkout_colorOptionName") }
        public static var colourOptionName: String { LocalizationManager.shared.localizedString(for: "checkout_colourOptionName") }
        public static var defaultVariantName: String { LocalizationManager.shared.localizedString(for: "checkout_defaultVariantName") }
        public static var processingKeepOpen: String { LocalizationManager.shared.localizedString(for: "checkout_processing_keep_open") }
        public static var failureTitle: String { LocalizationManager.shared.localizedString(for: "checkout_failure_title") }
        public static var tryAgain: String { LocalizationManager.shared.localizedString(for: "checkout_try_again") }
    }
    
    public enum HomeStrs {
        public static var placeholder: String { LocalizationManager.shared.localizedString(for: "homestrs_placeholder") }
        public static var categoriesSectionTitle: String { LocalizationManager.shared.localizedString(for: "homestrs_categories_sectionTitle") }
        public static var brandsTitle: String { LocalizationManager.shared.localizedString(for: "homestrs_brandsTitle") }
        public static var sortButton: String { LocalizationManager.shared.localizedString(for: "homestrs_sortButton") }
        public static var filterButton: String { LocalizationManager.shared.localizedString(for: "homestrs_filterButton") }
        public static var dealSectionTitle: String { LocalizationManager.shared.localizedString(for: "homestrs_deal_sectionTitle") }
        public static var viewAll: String { LocalizationManager.shared.localizedString(for: "homestrs_viewAll") }
        public static var remaining: String { LocalizationManager.shared.localizedString(for: "homestrs_remaining") }
        public static var offersTitle: String { LocalizationManager.shared.localizedString(for: "homestrs_offers_title") }
        public static var offersSubtitle: String { LocalizationManager.shared.localizedString(for: "homestrs_offers_subtitle") }
        public static var cta: String { LocalizationManager.shared.localizedString(for: "homestrs_cta") }
        public static var trendingSectionTitle: String { LocalizationManager.shared.localizedString(for: "homestrs_trending_sectionTitle") }
        public static var lastDate: String { LocalizationManager.shared.localizedString(for: "homestrs_lastDate") }
        public static func resultsCount(_ count: Int) -> String {
            String(format: LocalizationManager.shared.localizedString(for: "homestrs_results_count"), count)
        }
        public static var sortFeatured: String { LocalizationManager.shared.localizedString(for: "homestrs_sort_featured") }
        public static var sortPriceLowToHigh: String { LocalizationManager.shared.localizedString(for: "homestrs_sort_price_low_high") }
        public static var sortPriceHighToLow: String { LocalizationManager.shared.localizedString(for: "homestrs_sort_price_high_low") }
        public static var sortNewest: String { LocalizationManager.shared.localizedString(for: "homestrs_sort_newest") }
        public static var banner1Title: String { LocalizationManager.shared.localizedString(for: "homestrs_banner1_title") }
        public static var banner1Subtitle: String { LocalizationManager.shared.localizedString(for: "homestrs_banner1_subtitle") }
        public static var banner2Title: String { LocalizationManager.shared.localizedString(for: "homestrs_banner2_title") }
        public static var banner2Subtitle: String { LocalizationManager.shared.localizedString(for: "homestrs_banner2_subtitle") }
        public static var banner3Title: String { LocalizationManager.shared.localizedString(for: "homestrs_banner3_title") }
        public static var banner3Subtitle: String { LocalizationManager.shared.localizedString(for: "homestrs_banner3_subtitle") }
        public static var bannerCtaCopyCode: String { LocalizationManager.shared.localizedString(for: "homestrs_banner_cta_copy_code") }
    }
    
    public enum Main {
        public static var signInRequired: String { LocalizationManager.shared.localizedString(for: "main_sign_in_required") }
        public static var guestMessage: String { LocalizationManager.shared.localizedString(for: "main_guest_message") }
        public static var signIn: String { LocalizationManager.shared.localizedString(for: "main_sign_in") }
        public static var cancel: String { LocalizationManager.shared.localizedString(for: "main_cancel") }
        public static var appName: String { LocalizationManager.shared.localizedString(for: "main_app_name") }
        public static var personalInformation: String { LocalizationManager.shared.localizedString(for: "main_personal_information") }
        public static var comingSoon: String { LocalizationManager.shared.localizedString(for: "main_coming_soon") }
        public static var tabHome: String { LocalizationManager.shared.localizedString(for: "main_tab_home") }
        public static var tabCart: String { LocalizationManager.shared.localizedString(for: "main_tab_cart") }
        public static var tabFavorites: String { LocalizationManager.shared.localizedString(for: "main_tab_favorites") }
        public static var tabProfile: String { LocalizationManager.shared.localizedString(for: "main_tab_profile") }
    }

}
