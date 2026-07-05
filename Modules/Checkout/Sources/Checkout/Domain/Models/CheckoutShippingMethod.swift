import Foundation

public enum CheckoutShippingMethod: String, CaseIterable, Identifiable, Sendable {
    case standard
    case express

    public var id: String { rawValue }

    var title: String {
        switch self {
        case .standard:
            return "Standard"
        case .express:
            return "Express"
        }
    }

    var code: String {
        title
    }

    var deliveryEstimate: String {
        switch self {
        case .standard:
            return "5 days"
        case .express:
            return "2 days"
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
