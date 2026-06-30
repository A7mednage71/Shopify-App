import Common

struct ProductInfoViewModelFactory {
    private let getProductInfoUseCase: any GetProductInfoUseCaseProtocol
    private let addItemToCartUseCase: any AddItemToCartUseCaseProtocol

    init(
        getProductInfoUseCase: any GetProductInfoUseCaseProtocol,
        addItemToCartUseCase: any AddItemToCartUseCaseProtocol
    ) {
        self.getProductInfoUseCase = getProductInfoUseCase
        self.addItemToCartUseCase = addItemToCartUseCase
    }

    @MainActor
    func makeViewModel() -> ProductInfoViewModel {
        ProductInfoViewModel(
            getProductInfoUseCase: getProductInfoUseCase,
            addItemToCartUseCase: addItemToCartUseCase
        )
    }
}
