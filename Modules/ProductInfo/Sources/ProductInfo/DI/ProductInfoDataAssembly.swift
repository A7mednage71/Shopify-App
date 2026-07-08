import Swinject
import Common

public struct ProductInfoDataAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(ProductInfoRemoteDataSource.self) { _ in
            ShopifyProductInfoRemoteDataSource(localizationManager: LocalizationManager.shared)
        }

        container.register(ProductInfoRepository.self) { resolver in
            ProductInfoRepositoryImpl(
                remoteDataSource: resolver.resolve(ProductInfoRemoteDataSource.self)!
            )
        }

        container.register(ProductComparisonRecommendationRepository.self) { _ in
            ProductComparisonRecommendationRepositoryImpl()
        }
    }
}
