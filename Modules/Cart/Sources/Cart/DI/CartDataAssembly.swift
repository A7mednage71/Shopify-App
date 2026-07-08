import Swinject
import Common

public struct CartDataAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CartLocalDataSource.self) { _ in
            KeychainCartLocalDataSource()
        }

        container.register(CartRemoteDataSource.self) { _ in
            ShopifyCartRemoteDataSource(localizationManager: LocalizationManager.shared)
        }

        container.register(CartManager.self) { _ in
            UserDefaultsCartManager()
        }

        container.register(CartRepository.self) { resolver in
            CartRepositoryImpl(
                localDataSource: resolver.resolve(CartLocalDataSource.self)!,
                remoteDataSource: resolver.resolve(CartRemoteDataSource.self)!,
                cartManager: resolver.resolve(CartManager.self)!
            )
        }
    }
}
