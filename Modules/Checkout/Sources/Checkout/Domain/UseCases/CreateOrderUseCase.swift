import Foundation
import Common

protocol CreateOrderUseCaseProtocol: Sendable {
    func execute(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentMethodType: CheckoutPaymentMethodType
    ) async throws -> Order
}

enum CreateOrderUseCaseError: LocalizedError, Equatable {
    case missingAddress
    case emptyCart
    case invalidLineItem
    case missingCurrency
    case invalidMoneyAmount(String)

    public var errorDescription: String? {
        switch self {
        case .missingAddress:
            return "Add a delivery address before placing your order."
        case .emptyCart:
            return "Your cart is empty."
        case .invalidLineItem:
            return "Some cart items are missing required variant details."
        case .missingCurrency:
            return "Cart currency is missing."
        case .invalidMoneyAmount(let amount):
            return "Invalid cart amount: \(amount)"
        }
    }
}

struct CreateOrderUseCase: CreateOrderUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider

    init(
        repository: CheckoutRepository,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider
    ) {
        self.repository = repository
        self.paymentStrategyProvider = paymentStrategyProvider
    }

    func execute(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentMethodType: CheckoutPaymentMethodType
    ) async throws -> Order {
        let paymentStrategy = try paymentStrategyProvider.strategy(for: paymentMethodType)
        let input = try makeOrderCreateInput(
            cart: cart,
            customerDetails: customerDetails,
            paymentStrategy: paymentStrategy
        )

        return try await repository.createOrder(input: input)
    }

    private func makeOrderCreateInput(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentStrategy: any CheckoutPaymentStrategy
    ) throws -> OrderCreateInput {
        guard !cart.isEmpty else {
            throw CreateOrderUseCaseError.emptyCart
        }

        guard let address = customerDetails.defaultAddress else {
            throw CreateOrderUseCaseError.missingAddress
        }

        let lineItems = try cart.lines.map { line -> LineItemInput in
            guard line.quantity > 0,
                  let variantId = line.variant?.id,
                  !variantId.isEmpty else {
                throw CreateOrderUseCaseError.invalidLineItem
            }

            return LineItemInput(variantId: variantId, quantity: line.quantity)
        }

        guard !lineItems.isEmpty else {
            throw CreateOrderUseCaseError.emptyCart
        }

        let currency = try orderCurrency(from: cart)
        let totalAmount = try decimalAmount(from: cart.cost.totalAmount)
        let discount = try discountDetails(from: cart)

        return OrderCreateInput(
            currency: currency,
            email: customerDetails.email,
            phone: customerDetails.phone,
            customerId: customerDetails.id,
            lineItems: lineItems,
            shippingAddress: shippingAddress(from: address),
            shippingLine: nil,
            discountAmount: discount.amount,
            discountCode: discount.code,
            financialStatus: paymentStrategy.financialStatus,
            totalAmount: totalAmount
        )
    }

    private func orderCurrency(from cart: CartDetails) throws -> String {
        let currency = cart.cost.totalAmount.currencyCode.isEmpty
            ? cart.cost.subtotalAmount.currencyCode
            : cart.cost.totalAmount.currencyCode

        guard !currency.isEmpty else {
            throw CreateOrderUseCaseError.missingCurrency
        }

        return currency
    }

    private func shippingAddress(from address: CheckoutAddress) -> ShippingAddressInput {
        ShippingAddressInput(
            firstName: address.firstName,
            lastName: address.lastName ?? "Customer",
            company: address.company,
            address1: address.street,
            address2: address.street2,
            city: address.city,
            provinceCode: address.region,
            countryCode: address.countryCode?.isEmpty == false ? address.countryCode! : "EG",
            zip: address.postalCode,
            phone: address.phone
        )
    }

    private func discountDetails(from cart: CartDetails) throws -> (amount: Decimal?, code: String?) {
        guard let activeDiscount = cart.discountCodes.first(where: \.applicable) else {
            return (nil, nil)
        }

        let subtotal = try decimalAmount(from: cart.cost.subtotalAmount)
        let total = try decimalAmount(from: cart.cost.totalAmount)
        let discountAmount = subtotal - total

        guard discountAmount > 0 else {
            return (nil, nil)
        }

        return (discountAmount, activeDiscount.code)
    }

    private func decimalAmount(from money: CartMoney) throws -> Decimal {
        let normalizedAmount = money.amount.replacingOccurrences(of: ",", with: "")

        guard let amount = Decimal(string: normalizedAmount) else {
            throw CreateOrderUseCaseError.invalidMoneyAmount(money.amount)
        }

        return amount
    }
}
