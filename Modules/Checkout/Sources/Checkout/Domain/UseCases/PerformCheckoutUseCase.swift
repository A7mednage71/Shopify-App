import Common
import Foundation

public protocol PerformCheckoutUseCaseProtocol: Sendable {
    func execute(
        paymentMethodType: CheckoutPaymentMethodType,
        cart: CartDetails
    ) async throws -> CheckoutPaymentAction
}

public struct PerformCheckoutUseCase: PerformCheckoutUseCaseProtocol, Sendable {
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider

    public init(paymentStrategyProvider: CheckoutPaymentStrategyProvider) {
        self.paymentStrategyProvider = paymentStrategyProvider
    }

    public func execute(
        paymentMethodType: CheckoutPaymentMethodType,
        cart: CartDetails
    ) async throws -> CheckoutPaymentAction {
        guard let strategy = paymentStrategyProvider.strategy(for: paymentMethodType) else {
            return .none
        }

        return try await strategy.performCheckout(cart: cart)
    }
}

enum CheckoutPaymentError: LocalizedError {
    case missingCheckoutURL

    var errorDescription: String? {
        switch self {
        case .missingCheckoutURL:
            return "Checkout is not available for this cart."
        }
    }
}
