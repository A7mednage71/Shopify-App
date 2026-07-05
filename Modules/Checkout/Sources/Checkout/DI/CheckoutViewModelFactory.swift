import Common

struct CheckoutViewModelFactory {
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

    @MainActor
    func makeViewModel() -> CheckoutViewModel {
        CheckoutViewModel(
            getCurrentCartUseCase: getCurrentCartUseCase,
            createOrderUseCase: createOrderUseCase,
            getCustomerDetailsUseCase: getCustomerDetailsUseCase
        )
    }
}
