import Common

struct CheckoutViewModelFactory {
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
    }

    @MainActor
    func makeViewModel() -> CheckoutViewModel {
        CheckoutViewModel(
            getCurrentCartUseCase: getCurrentCartUseCase,
            paymentStrategyProvider: paymentStrategyProvider,
            performCheckoutUseCase: performCheckoutUseCase
        )
    }
}
