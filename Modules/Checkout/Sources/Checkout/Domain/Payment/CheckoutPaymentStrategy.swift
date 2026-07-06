import Foundation

enum CheckoutPaymentStrategyError: LocalizedError {
    case unsupportedPaymentMethod

     var errorDescription: String? {
        switch self {
        case .unsupportedPaymentMethod:
            return "This payment method is not available."
        }
    }
}

protocol CheckoutPaymentStrategy: Sendable {
    var paymentMethodType: CheckoutPaymentMethodType { get }
    var financialStatus: OrderFinancialStatus { get }
    var transactionStatus: OrderTransactionStatus { get }
    var gateway: String { get }
}

struct ApplePayPaymentStrategy: CheckoutPaymentStrategy {
    public let paymentMethodType = CheckoutPaymentMethodType.applePay
    public let financialStatus = OrderFinancialStatus.paid
    let transactionStatus = OrderTransactionStatus.success
    let gateway = "apple_pay"

     init() {}
}

struct CashOnDeliveryPaymentStrategy: CheckoutPaymentStrategy {
     let paymentMethodType = CheckoutPaymentMethodType.cashOnDelivery
     let financialStatus = OrderFinancialStatus.pending
     let transactionStatus = OrderTransactionStatus.pending
     let gateway = "cash_on_delivery"

     init() {}
}

struct CheckoutPaymentStrategyProvider: Sendable {
    private let strategies: [any CheckoutPaymentStrategy]

     init(
        strategies: [any CheckoutPaymentStrategy] = [
            ApplePayPaymentStrategy(),
            CashOnDeliveryPaymentStrategy()
        ]
    ) {
        self.strategies = strategies
    }

     var paymentMethods: [CheckoutPaymentMethodType] {
        strategies.map(\.paymentMethodType)
    }

     func strategy(for paymentMethodType: CheckoutPaymentMethodType) throws -> any CheckoutPaymentStrategy {
        guard let strategy = strategies.first(where: { $0.paymentMethodType == paymentMethodType }) else {
            throw CheckoutPaymentStrategyError.unsupportedPaymentMethod
        }

        return strategy
    }
}
