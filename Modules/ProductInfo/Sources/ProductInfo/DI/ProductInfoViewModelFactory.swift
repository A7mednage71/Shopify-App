import Common
import Favorites

struct ProductInfoViewModelFactory {
    private let getProductInfoUseCase: any GetProductInfoUseCaseProtocol
    private let addItemToCartUseCase: any AddItemToCartUseCaseProtocol
    private let manageFavoritesUseCase: any ManageFavoritesUseCase

    init(
        getProductInfoUseCase: any GetProductInfoUseCaseProtocol,
        addItemToCartUseCase: any AddItemToCartUseCaseProtocol,
        manageFavoritesUseCase: any ManageFavoritesUseCase
    ) {
        self.getProductInfoUseCase = getProductInfoUseCase
        self.addItemToCartUseCase = addItemToCartUseCase
        self.manageFavoritesUseCase = manageFavoritesUseCase
    }

    @MainActor
    func makeViewModel() -> ProductInfoViewModel {
        ProductInfoViewModel(
            getProductInfoUseCase: getProductInfoUseCase,
            addItemToCartUseCase: addItemToCartUseCase,
            manageFavoritesUseCase: manageFavoritesUseCase
        )
    }
}
