import Common
import Foundation

protocol CheckoutPricingUseCaseProtocol: Sendable {
    func execute(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) async -> CheckoutPricing

    func executeForOrder(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) async throws -> CheckoutPricing
}

struct CheckoutPricingUseCase: CheckoutPricingUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository
    private let now: @Sendable () -> Date

    init(
        repository: CheckoutRepository,
        now: @escaping @Sendable () -> Date = { Date() }
    ) {
        self.repository = repository
        self.now = now
    }

    func execute(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) async -> CheckoutPricing {
        do {
            return try await resolvePricing(
                cart: cart,
                shippingMethod: shippingMethod
            )
        } catch {
            if let code = cart.discountCodes.first(where: \.applicable)?.code {
                debugPrintDiscountRejection(
                    code: code,
                    reason: "Discount validation request failed: \(error.localizedDescription)",
                    cart: cart,
                    shippingMethod: shippingMethod
                )
            }

            return fallbackPricing(
                cart: cart,
                shippingMethod: shippingMethod,
                message: discountValidationUnavailableMessage
            )
        }
    }

    func executeForOrder(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) async throws -> CheckoutPricing {
        try await resolvePricing(
            cart: cart,
            shippingMethod: shippingMethod
        )
    }

    private func resolvePricing(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) async throws -> CheckoutPricing {
        let currencyCode = orderCurrency(from: cart)
        let subtotal = decimalAmount(from: cart.cost.subtotalAmount)

        guard let code = cart.discountCodes.first(where: \.applicable)?.code else {
            return CheckoutPricing(
                currencyCode: currencyCode,
                subtotal: subtotal,
                shippingMethod: shippingMethod,
                discountState: .none,
                discountAmount: 0,
                orderDiscount: nil
            )
        }

        guard let discount = try await repository.validateDiscountCode(code: code) else {
            debugPrintDiscountRejection(
                code: code,
                reason: "Admin returned no discount node for this code.",
                cart: cart,
                shippingMethod: shippingMethod
            )

            return invalidPricing(
                cart: cart,
                shippingMethod: shippingMethod,
                code: code,
                message: "This discount code is not available."
            )
        }

        return pricing(
            cart: cart,
            shippingMethod: shippingMethod,
            discount: discount
        )
    }

    private func pricing(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod,
        discount: ValidatedDiscountCode
    ) -> CheckoutPricing {
        let currencyCode = orderCurrency(from: cart)
        let subtotal = decimalAmount(from: cart.cost.subtotalAmount)

        if let invalidReason = invalidReason(
            for: discount,
            cart: cart,
            subtotal: subtotal,
            currencyCode: currencyCode,
            shippingMethod: shippingMethod
        ) {
            debugPrintDiscountRejection(
                code: discount.code,
                reason: invalidReason,
                cart: cart,
                shippingMethod: shippingMethod,
                discount: discount
            )

            return CheckoutPricing(
                currencyCode: currencyCode,
                subtotal: subtotal,
                shippingMethod: shippingMethod,
                discountState: .notApplicable(code: discount.code, message: invalidReason),
                discountAmount: 0,
                orderDiscount: nil
            )
        }

        switch discount.value {
        case .fixedAmount(let amount, let discountCurrencyCode, let appliesOnEachItem):
            let rawAmount = appliesOnEachItem ? amount * Decimal(cart.totalQuantity) : amount
            let discountAmount = min(rawAmount, subtotal)

            return CheckoutPricing(
                currencyCode: currencyCode,
                subtotal: subtotal,
                shippingMethod: shippingMethod,
                discountState: .applied(code: discount.code),
                discountAmount: discountAmount,
                orderDiscount: .itemFixed(
                    code: discount.code,
                    amount: discountAmount,
                    currencyCode: discountCurrencyCode
                )
            )

        case .percentage(let percentage):
            let displayPercentage = normalizedPercentage(percentage)
            let discountAmount = subtotal * Decimal(displayPercentage)

            return CheckoutPricing(
                currencyCode: currencyCode,
                subtotal: subtotal,
                shippingMethod: shippingMethod,
                discountState: .applied(code: discount.code),
                discountAmount: min(discountAmount, subtotal),
                orderDiscount: .itemPercentage(
                    code: discount.code,
                    percentage: percentage
                )
            )

        case .freeShipping:
            return CheckoutPricing(
                currencyCode: currencyCode,
                subtotal: subtotal,
                shippingMethod: shippingMethod,
                discountState: .applied(code: discount.code),
                discountAmount: shippingMethod.amount,
                orderDiscount: .freeShipping(code: discount.code)
            )
        }
    }

    private func invalidReason(
        for discount: ValidatedDiscountCode,
        cart: CartDetails,
        subtotal: Decimal,
        currencyCode: String,
        shippingMethod: CheckoutShippingMethod
    ) -> String? {
        guard discount.status == "ACTIVE" else {
            return L10n.Checkout.discountInactive
        }

        if let startsAt = discount.startsAt, startsAt > now() {
            return L10n.Checkout.discountInactiveYet
        }

        if let endsAt = discount.endsAt, endsAt <= now() {
            return L10n.Checkout.discountExpired
        }

        if discount.isUsageLimitReached {
            return L10n.Checkout.discountUsageLimitReached
        }

        if let minimumRequirement = discount.minimumRequirement {
            switch minimumRequirement {
            case .quantity(let minimumQuantity):
                guard cart.totalQuantity >= minimumQuantity else {
                    return L10n.Checkout.discountMinimumQuantity(minimumQuantity)
                }

            case .subtotal(let amount, let requirementCurrencyCode):
                guard requirementCurrencyCode == currencyCode else {
                    return L10n.Checkout.discountCurrencyMismatch
                }

                guard subtotal >= amount else {
                    return L10n.Checkout.discountHigherSubtotalRequired
                }
            }
        }

        switch discount.value {
        case .fixedAmount(_, let discountCurrencyCode, _):
            guard discount.appliesToAllItems else {
                return L10n.Checkout.discountSelectedProductsOnly
            }

            guard discountCurrencyCode == currencyCode else {
                return L10n.Checkout.discountCurrencyMismatch
            }

        case .percentage:
            guard discount.appliesToAllItems else {
                return L10n.Checkout.discountSelectedProductsOnly
            }

        case .freeShipping(let maximumShippingPrice, let shippingCurrencyCode):
            if let shippingCurrencyCode, shippingCurrencyCode != currencyCode {
                return L10n.Checkout.discountCurrencyMismatch
            }

            if let maximumShippingPrice, shippingMethod.amount > maximumShippingPrice {
                return L10n.Checkout.discountShippingMethodUnsupported
            }
        }

        return nil
    }

    private func invalidPricing(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod,
        code: String,
        message: String
    ) -> CheckoutPricing {
        CheckoutPricing(
            currencyCode: orderCurrency(from: cart),
            subtotal: decimalAmount(from: cart.cost.subtotalAmount),
            shippingMethod: shippingMethod,
            discountState: .notApplicable(code: code, message: message),
            discountAmount: 0,
            orderDiscount: nil
        )
    }

    private func fallbackPricing(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod,
        message: String
    ) -> CheckoutPricing {
        if let code = cart.discountCodes.first(where: \.applicable)?.code {
            return invalidPricing(
                cart: cart,
                shippingMethod: shippingMethod,
                code: code,
                message: message
            )
        }

        return CheckoutPricing(
            currencyCode: orderCurrency(from: cart),
            subtotal: decimalAmount(from: cart.cost.subtotalAmount),
            shippingMethod: shippingMethod,
            discountState: .none,
            discountAmount: 0,
            orderDiscount: nil
        )
    }

    private func orderCurrency(from cart: CartDetails) -> String {
        cart.cost.totalAmount.currencyCode.isEmpty
            ? cart.cost.subtotalAmount.currencyCode
            : cart.cost.totalAmount.currencyCode
    }

    private func decimalAmount(from money: CartMoney) -> Decimal {
        Decimal(string: money.amount.replacingOccurrences(of: ",", with: "")) ?? 0
    }

    private func normalizedPercentage(_ percentage: Double) -> Double {
        percentage > 1 ? percentage / 100 : percentage
    }

    private var discountValidationUnavailableMessage: String {
        "We could not apply this discount at checkout. You can continue without it."
    }

    private func debugPrintDiscountRejection(
        code: String,
        reason: String,
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod,
        discount: ValidatedDiscountCode? = nil
    ) {
        #if DEBUG
        var lines = [
            "[CheckoutDiscount] Rejected cart discount code: \(code)",
            "Reason: \(reason)",
            "Cart subtotal: \(cart.cost.subtotalAmount.amount) \(cart.cost.subtotalAmount.currencyCode)",
            "Cart total: \(cart.cost.totalAmount.amount) \(cart.cost.totalAmount.currencyCode)",
            "Cart quantity: \(cart.totalQuantity)",
            "Shipping: \(shippingMethod.title) \(shippingMethod.amount) \(orderCurrency(from: cart))"
        ]

        if let discount {
            lines.append(contentsOf: [
                "Admin title: \(discount.title)",
                "Admin status: \(discount.status)",
                "Admin startsAt: \(discount.startsAt?.description ?? "nil")",
                "Admin endsAt: \(discount.endsAt?.description ?? "nil")",
                "Admin usage: \(discount.usageCount)/\(discount.usageLimit.map(String.init) ?? "unlimited")",
                "Admin appliesToAllItems: \(discount.appliesToAllItems)",
                "Admin minimumRequirement: \(debugDescription(for: discount.minimumRequirement))",
                "Admin value: \(debugDescription(for: discount.value))"
            ])
        }

        print(lines.joined(separator: "\n"))
        #endif
    }

    private func debugDescription(for requirement: DiscountMinimumRequirement?) -> String {
        guard let requirement else {
            return "none"
        }

        switch requirement {
        case .quantity(let quantity):
            return "quantity >= \(quantity)"
        case .subtotal(let amount, let currencyCode):
            return "subtotal >= \(amount) \(currencyCode)"
        }
    }

    private func debugDescription(for value: ValidatedDiscountValue) -> String {
        switch value {
        case .fixedAmount(let amount, let currencyCode, let appliesOnEachItem):
            return "fixed \(amount) \(currencyCode), appliesOnEachItem: \(appliesOnEachItem)"
        case .percentage(let percentage):
            return "percentage \(percentage)"
        case .freeShipping(let maximumShippingPrice, let currencyCode):
            return "freeShipping max: \(maximumShippingPrice?.description ?? "nil") \(currencyCode ?? "")"
        }
    }
}
