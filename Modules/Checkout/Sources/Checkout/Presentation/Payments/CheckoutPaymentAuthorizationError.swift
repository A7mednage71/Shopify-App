import Foundation
import Common

enum CheckoutPaymentAuthorizationError: LocalizedError, Equatable {
    case applePayUnavailable
    case userCancelled
    case presentationFailed
    case missingMerchantIdentifier

    var errorDescription: String? {
        switch self {
        case .applePayUnavailable:
            return L10n.Checkout.errorApplePayUnavailable
        case .userCancelled:
            return nil
        case .presentationFailed:
            return L10n.Checkout.errorApplePayPresentationFailed
        case .missingMerchantIdentifier:
            return L10n.Checkout.errorApplePayMissingMerchantIdentifier
        }
    }
}
