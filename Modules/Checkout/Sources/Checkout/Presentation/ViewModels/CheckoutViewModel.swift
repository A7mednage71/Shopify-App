import Common
import Foundation

@MainActor
public final class CheckoutViewModel: ObservableObject {
    @Published private(set) var state: CheckoutViewState = .idle
    @Published private(set) var addressState: CheckoutAddressViewState = .loading
    @Published private(set) var paymentSelection = CheckoutPaymentSelectionState()
    @Published private(set) var shippingSelection = CheckoutShippingSelectionState()
    @Published private(set) var orderPlacement = CheckoutOrderPlacementState()

    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let createOrderUseCase: any CreateOrderUseCaseProtocol
    private let getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol
    private let checkoutPricingUseCase: any CheckoutPricingUseCaseProtocol
    private let paymentAuthorizer: any CheckoutPaymentAuthorizing

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        createOrderUseCase: any CreateOrderUseCaseProtocol,
        getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol,
        checkoutPricingUseCase: any CheckoutPricingUseCaseProtocol,
        paymentAuthorizer: any CheckoutPaymentAuthorizing
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.createOrderUseCase = createOrderUseCase
        self.getCustomerDetailsUseCase = getCustomerDetailsUseCase
        self.checkoutPricingUseCase = checkoutPricingUseCase
        self.paymentAuthorizer = paymentAuthorizer
    }

    func load() async {
        state = .loading
        addressState = .loading
        orderPlacement.dismissError()
        shippingSelection.clearPricing()

        do {
            async let cart = getCurrentCartUseCase.execute()
            async let customerDetails = getCustomerDetailsUseCase.execute()
            let loadedState = try await CheckoutLoadedState(
                cart: cart,
                customerDetails: customerDetails
            )

            state = .success(loadedState)
            addressState = loadedState.customerDetails.defaultAddress.map(CheckoutAddressViewState.success) ?? .empty
            await refreshPricing(for: loadedState.cart)
        } catch {
            addressState = .failure(error.localizedDescription)
            state = .failure(error.localizedDescription)
        }
    }

    func selectPaymentMethod(_ type: CheckoutPaymentMethodType) {
        paymentSelection.select(type)
        orderPlacement.dismissError()
    }

    func selectShippingMethod(_ method: CheckoutShippingMethod) {
        shippingSelection.select(method)
        orderPlacement.dismissError()

        guard let cart = state.loadedState?.cart else { return }

        Task {
            await refreshPricing(for: cart)
        }
    }

    func checkoutNow() async {
        guard let loadedState = state.loadedState,
              let pricing = shippingSelection.pricing else { return }

        orderPlacement.start(message: loadingMessage(for: paymentSelection.selectedMethodType))

        do {
            if paymentSelection.selectedMethodType == .applePay {
                try await paymentAuthorizer.authorizeApplePay(
                    cart: loadedState.cart,
                    customerDetails: loadedState.customerDetails,
                    pricing: pricing
                )
                orderPlacement.updateLoadingMessage(CheckoutText.placingOrderMessage)
            }

            try await placeOrder(loadedState: loadedState, pricing: pricing)
        } catch CheckoutPaymentAuthorizationError.userCancelled {
            orderPlacement.cancel()
        } catch {
            orderPlacement.fail(with: error.localizedDescription)
        }
    }

    func dismissCheckoutError() {
        orderPlacement.dismissError()
    }

    private func refreshPricing(for cart: CartDetails) async {
        let pricing = await checkoutPricingUseCase.execute(
            cart: cart,
            shippingMethod: shippingSelection.selectedMethod
        )

        shippingSelection.updatePricing(pricing)
    }

    private func loadingMessage(for paymentMethodType: CheckoutPaymentMethodType) -> String {
        switch paymentMethodType {
        case .applePay:
            return CheckoutText.openingApplePayMessage
        case .cashOnDelivery:
            return CheckoutText.placingOrderMessage
        }
    }

    private func placeOrder(
        loadedState: CheckoutLoadedState,
        pricing: CheckoutPricing
    ) async throws {
        _ = try await createOrderUseCase.execute(
            cart: loadedState.cart,
            customerDetails: loadedState.customerDetails,
            paymentMethodType: paymentSelection.selectedMethodType,
            shippingMethod: pricing.shippingMethod
        )

        orderPlacement.confirm(
            CheckoutOrderConfirmation(
                cart: loadedState.cart,
                paymentMethodTitle: paymentSelection.selectedMethodTitle,
                pricing: pricing
            )
        )
    }
}
