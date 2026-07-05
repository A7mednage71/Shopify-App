import Swinject

struct HomePresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewModel.self) { r in
            MainActor.assumeIsolated {
                HomeViewModel(
                    getCategoriesUseCase: r.resolve(GetCategoriesUseCaseProtocol.self)!,
                    getBrandsUseCase: r.resolve(GetBrandsUseCaseProtocol.self)!,
                    searchProductsUseCase: r.resolve(SearchProductsUseCaseProtocol.self)!,
                    getTrendingProductsUseCase: r.resolve(GetTrendingProductsUseCaseProtocol.self)!,
                    getSpecialOffersUseCase: r.resolve(GetSpecialOffersUseCaseProtocol.self)!,
                    getProductsByVendorUseCase: r.resolve(GetProductsByVendorUseCaseProtocol.self)!,
                    getProductsByCategoryUseCase: r.resolve(GetProductsByCategoryUseCaseProtocol.self)!
                )
            }
        }
    }
}
