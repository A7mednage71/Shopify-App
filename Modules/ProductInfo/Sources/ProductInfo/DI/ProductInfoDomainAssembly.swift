import Swinject

public struct ProductInfoDomainAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(GetProductInfoUseCaseProtocol.self) { resolver in
            GetProductInfoUseCase(
                repository: resolver.resolve(ProductInfoRepository.self)!
            )
        }

        container.register(GetComparableProductsUseCaseProtocol.self) { resolver in
            GetComparableProductsUseCase(
                repository: resolver.resolve(ProductInfoRepository.self)!
            )
        }

        container.register(GetProductComparisonRecommendationUseCaseProtocol.self) { resolver in
            GetProductComparisonRecommendationUseCase(
                repository: resolver.resolve(ProductComparisonRecommendationRepository.self)!
            )
        }
    }
}
