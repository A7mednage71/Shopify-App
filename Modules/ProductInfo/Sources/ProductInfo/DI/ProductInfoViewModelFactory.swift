import Common
import Favorites

struct ProductInfoViewModelFactory {
    private let getProductInfoUseCase: any GetProductInfoUseCaseProtocol
    private let getComparableProductsUseCase: any GetComparableProductsUseCaseProtocol
    private let getProductComparisonRecommendationUseCase: any GetProductComparisonRecommendationUseCaseProtocol
    private let addItemToCartUseCase: any AddItemToCartUseCaseProtocol
    private let manageFavoritesUseCase: any ManageFavoritesUseCase

    init(
        getProductInfoUseCase: any GetProductInfoUseCaseProtocol,
        getComparableProductsUseCase: any GetComparableProductsUseCaseProtocol,
        getProductComparisonRecommendationUseCase: any GetProductComparisonRecommendationUseCaseProtocol,
        addItemToCartUseCase: any AddItemToCartUseCaseProtocol,
        manageFavoritesUseCase: any ManageFavoritesUseCase
    ) {
        self.getProductInfoUseCase = getProductInfoUseCase
        self.getComparableProductsUseCase = getComparableProductsUseCase
        self.getProductComparisonRecommendationUseCase = getProductComparisonRecommendationUseCase
        self.addItemToCartUseCase = addItemToCartUseCase
        self.manageFavoritesUseCase = manageFavoritesUseCase
    }

    @MainActor
    func makeViewModel() -> ProductInfoViewModel {
        ProductInfoViewModel(
            getProductInfoUseCase: getProductInfoUseCase,
            comparisonViewModel: ProductComparisonViewModel(
                getComparableProductsUseCase: getComparableProductsUseCase,
                getRecommendationUseCase: getProductComparisonRecommendationUseCase
            ),
            addItemToCartUseCase: addItemToCartUseCase,
            manageFavoritesUseCase: manageFavoritesUseCase
        )
    }
}
