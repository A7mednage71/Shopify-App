import Common
import Foundation

@MainActor
public final class CheckoutViewModel: ObservableObject {
    @Published private(set) var state: CheckoutViewState = .idle
    @Published private(set) var addressState: CheckoutAddressViewState = .loading
    @Published private(set) var paymentSelection = CheckoutPaymentSelectionState()
    @Published private(set) var orderPlacement = CheckoutOrderPlacementState()

    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let createOrderUseCase: any CreateOrderUseCaseProtocol
    private let getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        createOrderUseCase: any CreateOrderUseCaseProtocol,
        getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.createOrderUseCase = createOrderUseCase
        self.getCustomerDetailsUseCase = getCustomerDetailsUseCase
    }

    func load() async {
        state = .loading
        addressState = .loading
        orderPlacement.dismissError()

        do {
            async let cart = getCurrentCartUseCase.execute()
            async let customerDetails = getCustomerDetailsUseCase.execute()
            let loadedState = try await CheckoutLoadedState(
                cart: cart,
                customerDetails: customerDetails
            )

            state = .success(loadedState)
            addressState = loadedState.customerDetails.defaultAddress.map(CheckoutAddressViewState.success) ?? .empty
        } catch {
            addressState = .failure(error.localizedDescription)
            state = .failure(error.localizedDescription)
        }
    }

    func selectPaymentMethod(_ type: CheckoutPaymentMethodType) {
        paymentSelection.select(type)
        orderPlacement.dismissError()
    }

    func checkoutNow() async {
        guard let loadedState = state.loadedState else { return }

        orderPlacement.start()

        do {
            _ = try await createOrderUseCase.execute(
                cart: loadedState.cart,
                customerDetails: loadedState.customerDetails,
                paymentMethodType: paymentSelection.selectedMethodType
            )

            orderPlacement.confirm(
                CheckoutOrderConfirmation(
                    cart: loadedState.cart,
                    paymentMethodTitle: paymentSelection.selectedMethodTitle
                )
            )
        } catch {
            orderPlacement.fail(with: error.localizedDescription)
        }
    }

    func dismissCheckoutError() {
        orderPlacement.dismissError()
    }
}
