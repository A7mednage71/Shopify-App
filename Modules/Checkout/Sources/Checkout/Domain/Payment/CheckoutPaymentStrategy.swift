import Common
import Foundation

public enum CheckoutPaymentError: LocalizedError {
    case missingCheckoutURL

    public var errorDescription: String? {
        switch self {
        case .missingCheckoutURL:
            return "The checkout URL is missing from the cart."
        }
    }
}

public protocol CheckoutPaymentStrategy: Sendable {
    var method: CheckoutPaymentMethod { get }
    func performCheckout(cart: CartDetails) async throws -> CheckoutPaymentAction
}

public struct CardPaymentStrategy: CheckoutPaymentStrategy {
    public let method = CheckoutPaymentMethod(
        type: .card,
        title: "Card",
        subtitle: "Pay securely with your saved card",
        systemImageName: "creditcard.fill"
    )

    public init() {}

    public func performCheckout(cart: CartDetails) async throws -> CheckoutPaymentAction {
        guard let checkoutUrl = cart.checkoutUrl,
              let url = URL(string: checkoutUrl) else {
            throw CheckoutPaymentError.missingCheckoutURL
        }

        return .presentWebCheckout(url)
    }
}

public struct ApplePayPaymentStrategy: CheckoutPaymentStrategy {
    public let method = CheckoutPaymentMethod(
        type: .applePay,
        title: "Apple Pay",
        subtitle: "Fast checkout with Apple Pay",
        systemImageName: "apple.logo"
    )

    public init() {}

    public func performCheckout(cart: CartDetails) async throws -> CheckoutPaymentAction {
        .none
    }
}

public struct CashOnDeliveryPaymentStrategy: CheckoutPaymentStrategy {
    public let method = CheckoutPaymentMethod(
        type: .cashOnDelivery,
        title: "Cash on Delivery",
        subtitle: "Pay when your order arrives",
        systemImageName: "banknote.fill"
    )

    public init() {}

    public func performCheckout(cart: CartDetails) async throws -> CheckoutPaymentAction {
        .none
    }
}

public struct CheckoutPaymentStrategyProvider: Sendable {
    private let strategies: [any CheckoutPaymentStrategy]

    public init(
        strategies: [any CheckoutPaymentStrategy] = [
            CardPaymentStrategy(),
            ApplePayPaymentStrategy(),
            CashOnDeliveryPaymentStrategy()
        ]
    ) {
        self.strategies = strategies
    }

    public var methods: [CheckoutPaymentMethod] {
        strategies.map(\.method)
    }

    public func strategy(for type: CheckoutPaymentMethodType) -> (any CheckoutPaymentStrategy)? {
        strategies.first { $0.method.type == type }
    }
}
