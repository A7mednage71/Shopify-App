import Common
import Foundation

@MainActor
public final class CheckoutViewModel: ObservableObject {
    @Published public private(set) var state: CheckoutViewState = .idle
    @Published public private(set) var addressState: CheckoutAddressViewState = .loading
    @Published public private(set) var paymentMethods: [CheckoutPaymentMethod]
    @Published public private(set) var selectedPaymentMethodType: CheckoutPaymentMethodType

    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.paymentStrategyProvider = paymentStrategyProvider
        self.paymentMethods = paymentStrategyProvider.methods
        self.selectedPaymentMethodType = paymentStrategyProvider.methods.first?.type ?? .card
    }

    public var selectedPaymentMethod: CheckoutPaymentMethod? {
        paymentMethods.first { $0.type == selectedPaymentMethodType }
    }

    public func load() async {
        state = .loading
        addressState = .loading

        do {
            let cart = try await getCurrentCartUseCase.execute()
            addressState = .empty
            state = .success(cart)
        } catch {
            addressState = .empty
            state = .failure(error.localizedDescription)
        }
    }

    public func selectPaymentMethod(_ type: CheckoutPaymentMethodType) {
        selectedPaymentMethodType = type
    }

    public func checkoutNow() {
        _ = paymentStrategyProvider.strategy(for: selectedPaymentMethodType)
    }
}
