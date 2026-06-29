import Swinject

struct ProductInfoDataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductInfoRemoteDataSource.self) { _ in
            ShopifyProductInfoRemoteDataSource()
        }

        container.register(ProductInfoRepository.self) { resolver in
            ProductInfoRepositoryImpl(
                remoteDataSource: resolver.resolve(ProductInfoRemoteDataSource.self)!
            )
        }
    }
}
