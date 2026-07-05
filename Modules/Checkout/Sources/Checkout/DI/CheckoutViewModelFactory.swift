import Common

struct CheckoutViewModelFactory {
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider
    
    // Use cases
    private let createOrderUseCase: any CreateOrderUseCaseProtocol
    private let getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol

    init(
        paymentStrategyProvider: CheckoutPaymentStrategyProvider,
        createOrderUseCase: any CreateOrderUseCaseProtocol,
        getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol
    ) {
        self.paymentStrategyProvider = paymentStrategyProvider
        self.createOrderUseCase = createOrderUseCase
        self.getCustomerDetailsUseCase = getCustomerDetailsUseCase
    }

    @MainActor
    func makeViewModel(cart: CartDetails) -> CheckoutViewModel {
        CheckoutViewModel(
            cart: cart,
            paymentStrategyProvider: paymentStrategyProvider,
            createOrderUseCase: createOrderUseCase,
            getCustomerDetailsUseCase: getCustomerDetailsUseCase
        )
    }
}
