import Foundation

public enum CheckoutPaymentAction: Sendable {
    case none
    case presentWebCheckout(URL)
}
