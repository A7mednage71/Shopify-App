import Foundation
import Common

protocol CreateOrderUseCaseProtocol: Sendable {
    func execute(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentMethodType: CheckoutPaymentMethodType,
        shippingMethod: CheckoutShippingMethod
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
            return L10n.Checkout.missingAddressToastMessage
        case .emptyCart:
            return L10n.Checkout.errorEmptyCart
        case .invalidLineItem:
            return L10n.Checkout.errorInvalidLineItem
        case .missingCurrency:
            return L10n.Checkout.errorMissingCurrency
        case .invalidMoneyAmount(let amount):
            return L10n.Checkout.errorInvalidMoneyAmount(amount)
        }
    }
}

struct CreateOrderUseCase: CreateOrderUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider
    private let checkoutPricingUseCase: any CheckoutPricingUseCaseProtocol
    private let createCartUseCase: any CreateCartUseCaseProtocol

    init(
        repository: CheckoutRepository,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider,
        checkoutPricingUseCase: any CheckoutPricingUseCaseProtocol,
        createCartUseCase: any CreateCartUseCaseProtocol
    ) {
        self.repository = repository
        self.paymentStrategyProvider = paymentStrategyProvider
        self.checkoutPricingUseCase = checkoutPricingUseCase
        self.createCartUseCase = createCartUseCase
    }

    func execute(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentMethodType: CheckoutPaymentMethodType,
        shippingMethod: CheckoutShippingMethod
    ) async throws -> Order {
        let paymentStrategy = try paymentStrategyProvider.strategy(for: paymentMethodType)
        let pricing = try await checkoutPricingUseCase.executeForOrder(
            cart: cart,
            shippingMethod: shippingMethod
        )
        let input = try makeOrderCreateInput(
            cart: cart,
            customerDetails: customerDetails,
            paymentStrategy: paymentStrategy,
            pricing: pricing
        )

        let order = try await repository.createOrder(input: input)
        await resetCartAfterOrderCreation()

        return order
    }

    private func resetCartAfterOrderCreation() async {
        do {
            _ = try await createCartUseCase.execute()
        } catch {
            print("[Checkout] Order created but failed to reset cart: \(error.localizedDescription)")
        }
    }

    private func makeOrderCreateInput(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentStrategy: any CheckoutPaymentStrategy,
        pricing: CheckoutPricing
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

        return OrderCreateInput(
            currency: currency,
            email: customerDetails.email,
            phone: customerDetails.phone,
            customerId: customerDetails.id,
            lineItems: lineItems,
            shippingAddress: shippingAddress(from: address),
            shippingLines: [
                shippingLine(
                    from: pricing.shippingMethod,
                    currencyCode: currency
                )
            ],
            discountCode: pricing.orderDiscount,
            financialStatus: paymentStrategy.financialStatus,
            transactionStatus: paymentStrategy.transactionStatus,
            transactionGateway: paymentStrategy.gateway,
            totalAmount: pricing.total
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

    private func shippingLine(
        from method: CheckoutShippingMethod,
        currencyCode: String
    ) -> ShippingLineInput {
        ShippingLineInput(
            title: method.title,
            code: method.code,
            source: method.source,
            amount: method.amount,
            currencyCode: currencyCode
        )
    }

    private func decimalAmount(from money: CartMoney) throws -> Decimal {
        let normalizedAmount = money.amount.replacingOccurrences(of: ",", with: "")

        guard let amount = Decimal(string: normalizedAmount) else {
            throw CreateOrderUseCaseError.invalidMoneyAmount(money.amount)
        }

        return amount
    }
}
