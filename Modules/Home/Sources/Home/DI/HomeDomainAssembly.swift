import Swinject

struct HomeDomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetCategoriesUseCaseProtocol.self) { resolver in
            GetCategoriesUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }

        container.register(GetBrandsUseCaseProtocol.self) { resolver in
            GetBrandsUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }

        container.register(GetProductsByCategoryUseCaseProtocol.self) { resolver in
            GetProductsByCategoryUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }

        container.register(SearchProductsUseCaseProtocol.self) { resolver in
            SearchProductsUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }

        container.register(GetTrendingProductsUseCaseProtocol.self) { resolver in
            GetTrendingProductsUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }

        container.register(GetSpecialOffersUseCaseProtocol.self) { resolver in
            GetSpecialOffersUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }

        container.register(GetProductsByVendorUseCaseProtocol.self) { resolver in
            GetProductsByVendorUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }
    }
}
