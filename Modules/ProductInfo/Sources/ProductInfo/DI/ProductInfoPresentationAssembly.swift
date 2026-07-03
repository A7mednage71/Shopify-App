import Common
import Swinject

public struct ProductInfoPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(ProductInfoViewModelFactory.self) { resolver in
            ProductInfoViewModelFactory(
                getProductInfoUseCase: resolver.resolve(GetProductInfoUseCaseProtocol.self)!,
                addItemToCartUseCase: resolver.resolve(AddItemToCartUseCaseProtocol.self)!
            )
        }

        container.register(ProductInfoViewFactory.self) { resolver in
            ProductInfoViewFactory(
                viewModelFactory: resolver.resolve(ProductInfoViewModelFactory.self)!
            )
        }
    }
}
