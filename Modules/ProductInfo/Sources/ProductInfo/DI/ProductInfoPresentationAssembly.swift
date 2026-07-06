import Common
import Swinject
import Favorites

public struct ProductInfoPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(ProductInfoViewModelFactory.self) { resolver in
            ProductInfoViewModelFactory(
                getProductInfoUseCase: resolver.resolve(GetProductInfoUseCaseProtocol.self)!,
                addItemToCartUseCase: resolver.resolve(AddItemToCartUseCaseProtocol.self)!,
                manageFavoritesUseCase: resolver.resolve(ManageFavoritesUseCase.self)!
            )
        }

        container.register(ProductInfoViewFactory.self) { resolver in
            ProductInfoViewFactory(
                viewModelFactory: resolver.resolve(ProductInfoViewModelFactory.self)!
            )
        }
    }
}
