import Common

struct CheckoutViewModelFactory {
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
    }

    @MainActor
    func makeViewModel() -> CheckoutViewModel {
        CheckoutViewModel(
            getCurrentCartUseCase: getCurrentCartUseCase,
            paymentStrategyProvider: paymentStrategyProvider,
            performCheckoutUseCase: performCheckoutUseCase,
            completeDraftOrderUseCase: completeDraftOrderUseCase
        )
    }
}
