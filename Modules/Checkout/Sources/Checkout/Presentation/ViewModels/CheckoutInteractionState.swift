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

struct CheckoutOrderPlacementState {
    private(set) var isPlacingOrder = false
    private(set) var errorMessage: String?
    private(set) var confirmation: CheckoutOrderConfirmation?

    var isCheckoutButtonDisabled: Bool {
        isPlacingOrder
    }

    mutating func start() {
        isPlacingOrder = true
        errorMessage = nil
        confirmation = nil
    }

    mutating func confirm(_ confirmation: CheckoutOrderConfirmation) {
        isPlacingOrder = false
        self.confirmation = confirmation
    }

    mutating func fail(with message: String) {
        isPlacingOrder = false
        errorMessage = message
    }

    mutating func dismissError() {
        errorMessage = nil
    }
}

public struct CheckoutOrderConfirmation: Identifiable {
    public let id = UUID()
    let cart: CartDetails
    let paymentMethodTitle: String

    init(
        cart: CartDetails,
        paymentMethodTitle: String
    ) {
        self.cart = cart
        self.paymentMethodTitle = paymentMethodTitle
    }
}
