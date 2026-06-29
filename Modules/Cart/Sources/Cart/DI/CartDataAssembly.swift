import Swinject

struct CartDataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CartRemoteDataSource.self) { _ in
            ShopifyCartRemoteDataSource()
        }

        container.register(CartManager.self) { _ in
            UserDefaultsCartManager()
        }

        container.register(CartRepository.self) { resolver in
            CartRepositoryImpl(
                remoteDataSource: resolver.resolve(CartRemoteDataSource.self)!,
                cartManager: resolver.resolve(CartManager.self)!
            )
        }
    }
}
