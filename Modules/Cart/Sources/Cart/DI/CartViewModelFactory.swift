struct CartViewModelFactory {
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol
    private let removeCartLineUseCase: any RemoveCartLineUseCaseProtocol
    private let applyDiscountCodeUseCase: any ApplyDiscountCodeUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol,
        removeCartLineUseCase: any RemoveCartLineUseCaseProtocol,
        applyDiscountCodeUseCase: any ApplyDiscountCodeUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.updateCartLineQuantityUseCase = updateCartLineQuantityUseCase
        self.removeCartLineUseCase = removeCartLineUseCase
        self.applyDiscountCodeUseCase = applyDiscountCodeUseCase
    }

    @MainActor
    func makeViewModel() -> CartViewModel {
        CartViewModel(
            getCurrentCartUseCase: getCurrentCartUseCase,
            updateCartLineQuantityUseCase: updateCartLineQuantityUseCase,
            removeCartLineUseCase: removeCartLineUseCase,
            applyDiscountCodeUseCase: applyDiscountCodeUseCase
        )
    }
}
