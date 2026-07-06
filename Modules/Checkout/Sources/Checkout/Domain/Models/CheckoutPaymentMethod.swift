import Foundation

enum CheckoutPaymentMethodType: String, CaseIterable, Identifiable, Sendable {
    case applePay
    case cashOnDelivery

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .applePay:
            return "Apple Pay"
        case .cashOnDelivery:
            return "Cash on Delivery"
        }
    }

    public var subtitle: String {
        switch self {
        case .applePay:
            return "Fast checkout with Apple Pay"
        case .cashOnDelivery:
            return "Pay when your order arrives"
        }
    }

    public var systemImageName: String {
        switch self {
        case .applePay:
            return "apple.logo"
        case .cashOnDelivery:
            return "banknote.fill"
        }
    }
}
