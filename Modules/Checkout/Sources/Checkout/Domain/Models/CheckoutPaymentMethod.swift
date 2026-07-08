import Foundation
import Common

enum CheckoutPaymentMethodType: String, CaseIterable, Identifiable, Sendable {
    case applePay
    case cashOnDelivery

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .applePay:
            return L10n.Checkout.paymentMethodApplePayTitle
        case .cashOnDelivery:
            return L10n.Checkout.paymentMethodCashOnDeliveryTitle
        }
    }

    public var subtitle: String {
        switch self {
        case .applePay:
            return L10n.Checkout.paymentMethodApplePaySubtitle
        case .cashOnDelivery:
            return L10n.Checkout.paymentMethodCashOnDeliverySubtitle
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
