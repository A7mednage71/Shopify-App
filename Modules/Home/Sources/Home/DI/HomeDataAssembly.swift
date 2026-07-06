import Swinject

struct HomeDataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeRemoteDataSource.self) { _ in
            ShopifyHomeRemoteDataSource()
        }

        container.register(HomeRepository.self) { resolver in
            HomeRepositoryImpl(
                remoteDataSource: resolver.resolve(HomeRemoteDataSource.self)!
            )
        }

        container.register(ShoppingAssistantRemoteDataSource.self) { _ in
            GeminiShoppingAssistantRemoteDataSource()
        }

        container.register(ShoppingAssistantRepository.self) { resolver in
            ShoppingAssistantRepositoryImpl(
                remoteDataSource: resolver.resolve(ShoppingAssistantRemoteDataSource.self)!
            )
        }
    }
}
