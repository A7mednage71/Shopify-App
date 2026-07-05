import Common

struct CheckoutViewModelFactory {
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

    @MainActor
    func makeViewModel() -> CheckoutViewModel {
        CheckoutViewModel(
            getCurrentCartUseCase: getCurrentCartUseCase,
            createOrderUseCase: createOrderUseCase,
            getCustomerDetailsUseCase: getCustomerDetailsUseCase,
            checkoutPricingUseCase: checkoutPricingUseCase,
            paymentAuthorizer: paymentAuthorizer
        )
    }
}
