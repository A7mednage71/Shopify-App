import Swinject

public struct ProductInfoDataAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
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
