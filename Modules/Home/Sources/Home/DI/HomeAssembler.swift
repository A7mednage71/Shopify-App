import Swinject
@MainActor
enum HomeAssembler {
    static func resolveGetCollectionsUseCase() -> any GetCollectionsUseCaseProtocol {
        makeAssembler().resolver.resolve(GetCollectionsUseCaseProtocol.self)!
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

    @MainActor
    static func resolveHomeViewModel() -> HomeViewModel {
        makeAssembler().resolver.resolve(HomeViewModel.self)!
    }
    private static func makeAssembler() -> Assembler {
        Assembler([
            HomeDataAssembly(),
            HomeDomainAssembly(),
            HomePresentationAssembly(),
        ])
    }
}
