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
    }
}
