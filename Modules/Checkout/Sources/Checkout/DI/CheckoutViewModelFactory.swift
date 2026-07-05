import Common

struct CheckoutViewModelFactory {
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider
    private let performCheckoutUseCase: any PerformCheckoutUseCaseProtocol
    private let createDraftOrderUseCase: any CreateDraftOrderUseCaseProtocol
    private let applyDraftOrderDiscountUseCase: any ApplyDraftOrderDiscountUseCaseProtocol
    private let completeDraftOrderUseCase: any CompleteDraftOrderUseCaseProtocol

    init(
        paymentStrategyProvider: CheckoutPaymentStrategyProvider,
        performCheckoutUseCase: any PerformCheckoutUseCaseProtocol,
        createDraftOrderUseCase: any CreateDraftOrderUseCaseProtocol,
        applyDraftOrderDiscountUseCase: any ApplyDraftOrderDiscountUseCaseProtocol,
        completeDraftOrderUseCase: any CompleteDraftOrderUseCaseProtocol
    ) {
        self.paymentStrategyProvider = paymentStrategyProvider
        self.performCheckoutUseCase = performCheckoutUseCase
        self.createDraftOrderUseCase = createDraftOrderUseCase
        self.applyDraftOrderDiscountUseCase = applyDraftOrderDiscountUseCase
        self.completeDraftOrderUseCase = completeDraftOrderUseCase
    }

    @MainActor
    func makeViewModel(cart: CartDetails) -> CheckoutViewModel {
        CheckoutViewModel(
            cart: cart,
            paymentStrategyProvider: paymentStrategyProvider,
            performCheckoutUseCase: performCheckoutUseCase,
            createDraftOrderUseCase: createDraftOrderUseCase,
            applyDraftOrderDiscountUseCase: applyDraftOrderDiscountUseCase,
            completeDraftOrderUseCase: completeDraftOrderUseCase
        )
    }
}
