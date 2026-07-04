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
    @Published var orderConfirmationRoute: CheckoutOrderConfirmationRoute?

    // Draft Order completion properties
    public enum SelectedPaymentMethod: String, Sendable {
        case applePaySimulated = "Apple Pay (Simulated)"
        case cashOnDelivery = "Cash on Delivery"
    }
    @Published public var selectedPaymentMethod: SelectedPaymentMethod = .applePaySimulated
    @Published public var isLoading = false
    @Published public var completedOrder: CompletedOrder?
    @Published public var error: String?
    @Published public var draftOrderId: String?

    private var isCompletingCheckout = false
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider
    private let performCheckoutUseCase: any PerformCheckoutUseCaseProtocol
    private let completeDraftOrderUseCase: any CompleteDraftOrderUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider,
        performCheckoutUseCase: any PerformCheckoutUseCaseProtocol,
        completeDraftOrderUseCase: any CompleteDraftOrderUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.paymentStrategyProvider = paymentStrategyProvider
        self.performCheckoutUseCase = performCheckoutUseCase
        self.completeDraftOrderUseCase = completeDraftOrderUseCase
        self.paymentMethods = paymentStrategyProvider.methods
        self.selectedPaymentMethodType = paymentStrategyProvider.methods.first?.type ?? .card
    }

    public var selectedPaymentMethodModel: CheckoutPaymentMethod? {
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
        orderConfirmationRoute = nil
        isCompletingCheckout = false

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

    public func completeOrder() async {
        guard let id = draftOrderId else { return }
        await completeOrder(draftOrderId: id)
    }

    public func completeOrder(draftOrderId: String) async {
        isLoading = true
        error = nil
        completedOrder = nil
        checkoutErrorMessage = nil
        
        let paymentPending = selectedPaymentMethod == .cashOnDelivery
        
        do {
            let completed = try await completeDraftOrderUseCase.execute(
                draftOrderId: draftOrderId,
                paymentPending: paymentPending
            )
            self.completedOrder = completed
            
            if case let .success(cart) = state {
                let route = CheckoutOrderConfirmationRoute(
                    completionURL: URL(string: "https://marktek.com/order-complete")!,
                    cart: cart,
                    paymentMethodTitle: selectedPaymentMethod.rawValue
                )
                self.orderConfirmationRoute = route
            }
        } catch {
            self.error = error.localizedDescription
            self.checkoutErrorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func checkoutCompleted(url: URL) {
        guard !isCompletingCheckout,
              case let .success(cart) = state else {
            webCheckoutRoute = nil
            return
        }

        isCompletingCheckout = true
        webCheckoutRoute = nil

        let confirmationRoute = CheckoutOrderConfirmationRoute(
            completionURL: url,
            cart: cart,
            paymentMethodTitle: selectedPaymentMethodModel?.title
        )

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 350_000_000)
            orderConfirmationRoute = confirmationRoute
        }
    }

    func dismissOrderConfirmation() {
        orderConfirmationRoute = nil
        isCompletingCheckout = false
    }
}

public struct CheckoutWebCheckoutRoute: Identifiable, Equatable {
    public let url: URL

    public var id: String {
        url.absoluteString
    }
}

public struct CheckoutOrderConfirmationRoute: Identifiable {
    public let id = UUID()
    let completionURL: URL
    let cart: CartDetails
    let paymentMethodTitle: String?
}
