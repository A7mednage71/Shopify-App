import Swinject

public struct CartDataAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CartLocalDataSource.self) { _ in
            DummyCartLocalDataSource()
        }

        container.register(CartRemoteDataSource.self) { _ in
            ShopifyCartRemoteDataSource()
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
