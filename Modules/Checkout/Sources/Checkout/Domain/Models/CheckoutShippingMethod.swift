import Foundation
import Common

public enum CheckoutShippingMethod: String, CaseIterable, Identifiable, Sendable {
    case standard
    case express

    public var id: String { rawValue }

    var title: String {
        switch self {
        case .standard:
            return L10n.Checkout.shippingMethodStandardTitle
        case .express:
            return L10n.Checkout.shippingMethodExpressTitle
        }
    }

    var code: String {
        title
    }

    var deliveryEstimate: String {
        switch self {
        case .standard:
            return L10n.Checkout.shippingMethodStandardEstimate
        case .express:
            return L10n.Checkout.shippingMethodExpressEstimate
        }
    }

    var amount: Decimal {
        switch self {
        case .standard:
            return 8
        case .express:
            return 15
        }
    }

    var source: String {
        "shopify"
    }
}
