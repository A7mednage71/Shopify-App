import Swinject

enum HomeAssembler {
    static func resolveGetCategoriesUseCase() -> any GetCategoriesUseCaseProtocol {
        makeAssembler().resolver.resolve(GetCategoriesUseCaseProtocol.self)!
    }

    static func resolveGetBrandsUseCase() -> any GetBrandsUseCaseProtocol {
        makeAssembler().resolver.resolve(GetBrandsUseCaseProtocol.self)!
    }

    static func resolveGetProductsByCategoryUseCase() -> any GetProductsByCategoryUseCaseProtocol {
        makeAssembler().resolver.resolve(GetProductsByCategoryUseCaseProtocol.self)!
    }

    static func resolveSearchProductsUseCase() -> any SearchProductsUseCaseProtocol {
        makeAssembler().resolver.resolve(SearchProductsUseCaseProtocol.self)!
    }

    static func resolveGetTrendingProductsUseCase() -> any GetTrendingProductsUseCaseProtocol {
        makeAssembler().resolver.resolve(GetTrendingProductsUseCaseProtocol.self)!
    }

    static func resolveGetSpecialOffersUseCase() -> any GetSpecialOffersUseCaseProtocol {
        makeAssembler().resolver.resolve(GetSpecialOffersUseCaseProtocol.self)!
    }

    static func resolveGetProductsByVendorUseCase() -> any GetProductsByVendorUseCaseProtocol {
        makeAssembler().resolver.resolve(GetProductsByVendorUseCaseProtocol.self)!
    }

    static func resolveGetProductsUseCase() -> any GetProductsUseCaseProtocol {
        makeAssembler().resolver.resolve(GetProductsUseCaseProtocol.self)!
    }

    @MainActor
    static func resolveHomeViewModel() -> HomeViewModel {
        makeAssembler().resolver.resolve(HomeViewModel.self)!
    }

    @MainActor
    static func resolveShoppingAssistantViewModel() -> ShoppingAssistantViewModel {
        makeAssembler().resolver.resolve(ShoppingAssistantViewModel.self)!
    }

    private static func makeAssembler() -> Assembler {
        Assembler([
            HomeDataAssembly(),
            HomeDomainAssembly(),
            HomePresentationAssembly(),
        ])
    }
}
