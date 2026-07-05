import Common
import Foundation

struct CheckoutPaymentSelectionState {
    let methods: [CheckoutPaymentMethodType]
    private(set) var selectedMethodType: CheckoutPaymentMethodType

    init(methods: [CheckoutPaymentMethodType] = CheckoutPaymentMethodType.allCases) {
        self.methods = methods
        self.selectedMethodType = methods.first ?? .applePay
    }

    var selectedMethodTitle: String {
        selectedMethodType.title
    }

    mutating func select(_ methodType: CheckoutPaymentMethodType) {
        selectedMethodType = methodType
    }
}

struct CheckoutShippingSelectionState {
    let methods: [CheckoutShippingMethod]
    private(set) var selectedMethod: CheckoutShippingMethod
    private(set) var pricing: CheckoutPricing?

    init(methods: [CheckoutShippingMethod] = CheckoutShippingMethod.allCases) {
        self.methods = methods
        self.selectedMethod = .standard
    }

    mutating func select(_ method: CheckoutShippingMethod) {
        selectedMethod = method
    }

    mutating func updatePricing(_ pricing: CheckoutPricing) {
        self.pricing = pricing
        selectedMethod = pricing.shippingMethod
    }

    mutating func clearPricing() {
        pricing = nil
        selectedMethod = .standard
    }
}

struct CheckoutOrderPlacementState {
    private(set) var isPlacingOrder = false
    private(set) var loadingMessage: String?
    private(set) var errorMessage: String?
    private(set) var confirmation: CheckoutOrderConfirmation?

    var isCheckoutButtonDisabled: Bool {
        isPlacingOrder
    }

    mutating func start(message: String) {
        isPlacingOrder = true
        loadingMessage = message
        errorMessage = nil
        confirmation = nil
    }

    mutating func updateLoadingMessage(_ message: String) {
        loadingMessage = message
    }

    mutating func confirm(_ confirmation: CheckoutOrderConfirmation) {
        isPlacingOrder = false
        loadingMessage = nil
        self.confirmation = confirmation
    }

    mutating func fail(with message: String) {
        isPlacingOrder = false
        loadingMessage = nil
        errorMessage = message
    }

    mutating func cancel() {
        isPlacingOrder = false
        loadingMessage = nil
    }

    mutating func dismissError() {
        errorMessage = nil
    }
}

public struct CheckoutOrderConfirmation: Identifiable {
    public let id = UUID()
    let cart: CartDetails
    let paymentMethodTitle: String
    let pricing: CheckoutPricing

    init(
        cart: CartDetails,
        paymentMethodTitle: String,
        pricing: CheckoutPricing
    ) {
        self.cart = cart
        self.paymentMethodTitle = paymentMethodTitle
        self.pricing = pricing
    }
}
