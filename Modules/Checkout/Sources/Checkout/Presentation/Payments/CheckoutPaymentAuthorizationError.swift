import Foundation

enum CheckoutPaymentAuthorizationError: LocalizedError, Equatable {
    case applePayUnavailable
    case userCancelled
    case presentationFailed
    case missingMerchantIdentifier

    var errorDescription: String? {
        switch self {
        case .applePayUnavailable:
            return "Apple Pay is not available on this device."
        case .userCancelled:
            return nil
        case .presentationFailed:
            return "We could not open Apple Pay. Please try again."
        case .missingMerchantIdentifier:
            return "Apple Pay is not configured for this app."
        }
    }
}
