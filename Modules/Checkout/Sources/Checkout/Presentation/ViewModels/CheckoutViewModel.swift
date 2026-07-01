import Common
import Foundation

@MainActor
public final class CheckoutViewModel: ObservableObject {
    @Published public private(set) var state: CheckoutViewState = .idle
    @Published public private(set) var addressState: CheckoutAddressViewState = .loading
    @Published public private(set) var paymentMethods: [CheckoutPaymentMethod]
    @Published public private(set) var selectedPaymentMethodType: CheckoutPaymentMethodType
    @Published public var webCheckoutRoute: CheckoutWebCheckoutRoute?
    @Published public var checkoutErrorMessage: String?

    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider
    private let performCheckoutUseCase: any PerformCheckoutUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider,
        performCheckoutUseCase: any PerformCheckoutUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.paymentStrategyProvider = paymentStrategyProvider
        self.performCheckoutUseCase = performCheckoutUseCase
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
        checkoutErrorMessage = nil
    }

    public func checkoutNow() async {
        guard case let .success(cart) = state else { return }

        checkoutErrorMessage = nil

        do {
            let action = try await performCheckoutUseCase.execute(
                paymentMethodType: selectedPaymentMethodType,
                cart: cart
            )

            switch action {
            case .none:
                break
            case .presentWebCheckout(let url):
                webCheckoutRoute = CheckoutWebCheckoutRoute(url: url)
            }
        } catch {
            checkoutErrorMessage = error.localizedDescription
        }
    }
}

public struct CheckoutWebCheckoutRoute: Identifiable, Equatable {
    public let url: URL

    public var id: String {
        url.absoluteString
    }
}
