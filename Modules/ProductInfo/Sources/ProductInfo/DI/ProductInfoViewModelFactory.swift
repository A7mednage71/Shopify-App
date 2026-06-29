struct ProductInfoViewModelFactory {
    private let getProductInfoUseCase: any GetProductInfoUseCaseProtocol

    init(getProductInfoUseCase: any GetProductInfoUseCaseProtocol) {
        self.getProductInfoUseCase = getProductInfoUseCase
    }

    @MainActor
    func makeViewModel() -> ProductInfoViewModel {
        ProductInfoViewModel(getProductInfoUseCase: getProductInfoUseCase)
    }
}
