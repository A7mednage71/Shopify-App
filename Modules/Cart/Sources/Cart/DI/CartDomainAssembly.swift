import Common
import Swinject

public struct CartDomainAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CreateCartUseCaseProtocol.self) { resolver in
            CreateCartUseCase(
                repository: resolver.resolve(CartRepository.self)!
            )
        }

        container.register(GetCurrentCartUseCaseProtocol.self) { resolver in
            GetCurrentCartUseCase(
                repository: resolver.resolve(CartRepository.self)!
            )
        }

        container.register(AddCartLinesUseCaseProtocol.self) { resolver in
            AddCartLinesUseCase(
                repository: resolver.resolve(CartRepository.self)!
            )
        }

        container.register(UpdateCartLinesUseCaseProtocol.self) { resolver in
            UpdateCartLinesUseCase(
                repository: resolver.resolve(CartRepository.self)!
            )
        }

        container.register(RemoveCartLinesUseCaseProtocol.self) { resolver in
            RemoveCartLinesUseCase(
                repository: resolver.resolve(CartRepository.self)!
            )
        }

        container.register(UpdateCartLineQuantityUseCaseProtocol.self) { resolver in
            UpdateCartLineQuantityUseCase(
                updateCartLinesUseCase: resolver.resolve(UpdateCartLinesUseCaseProtocol.self)!,
                getCurrentCartUseCase: resolver.resolve(GetCurrentCartUseCaseProtocol.self)!
            )
        }

        container.register(RemoveCartLineUseCaseProtocol.self) { resolver in
            RemoveCartLineUseCase(
                removeCartLinesUseCase: resolver.resolve(RemoveCartLinesUseCaseProtocol.self)!,
                getCurrentCartUseCase: resolver.resolve(GetCurrentCartUseCaseProtocol.self)!
            )
        }

        container.register(ApplyDiscountCodeUseCaseProtocol.self) { resolver in
            ApplyDiscountCodeUseCase(
                repository: resolver.resolve(CartRepository.self)!
            )
        }

        container.register(AddItemToCartUseCaseProtocol.self) { resolver in
            AddItemToCartUseCase(
                addCartLinesUseCase: resolver.resolve(AddCartLinesUseCaseProtocol.self)!
            )
        }
    }
}
