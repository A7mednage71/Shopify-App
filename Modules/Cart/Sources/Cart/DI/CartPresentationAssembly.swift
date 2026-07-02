import Swinject

public struct CartPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CartViewModelFactory.self) { resolver in
            CartViewModelFactory(
                getCurrentCartUseCase: resolver.resolve(GetCurrentCartUseCaseProtocol.self)!,
                updateCartLineQuantityUseCase: resolver.resolve(UpdateCartLineQuantityUseCaseProtocol.self)!,
                removeCartLineUseCase: resolver.resolve(RemoveCartLineUseCaseProtocol.self)!,
                applyDiscountCodeUseCase: resolver.resolve(ApplyDiscountCodeUseCaseProtocol.self)!
            )
        }

        container.register(CartViewFactory.self) { resolver in
            CartViewFactory(
                viewModelFactory: resolver.resolve(CartViewModelFactory.self)!
            )
        }
    }
}
