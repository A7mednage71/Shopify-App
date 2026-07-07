import Swinject
import Favorites

@MainActor
enum HomeAssembler {
    
    private static let assembler: Assembler = {
        Assembler([
            HomeDataAssembly(),
            HomeDomainAssembly(),
            HomePresentationAssembly(),
            FavoritesDataAssembly(),
            FavoritesDomainAssembly(),
        ])
    }()

    static func resolveGetCategoriesUseCase() -> any GetCategoriesUseCaseProtocol {
        assembler.resolver.resolve(GetCategoriesUseCaseProtocol.self)!
    }

    static func resolveGetBrandsUseCase() -> any GetBrandsUseCaseProtocol {
        assembler.resolver.resolve(GetBrandsUseCaseProtocol.self)!
    }

    static func resolveGetProductsByCategoryUseCase() -> any GetProductsByCategoryUseCaseProtocol {
        assembler.resolver.resolve(GetProductsByCategoryUseCaseProtocol.self)!
    }

    static func resolveSearchProductsUseCase() -> any SearchProductsUseCaseProtocol {
        assembler.resolver.resolve(SearchProductsUseCaseProtocol.self)!
    }

    static func resolveGetTrendingProductsUseCase() -> any GetTrendingProductsUseCaseProtocol {
        assembler.resolver.resolve(GetTrendingProductsUseCaseProtocol.self)!
    }

    static func resolveGetSpecialOffersUseCase() -> any GetSpecialOffersUseCaseProtocol {
        assembler.resolver.resolve(GetSpecialOffersUseCaseProtocol.self)!
    }

    static func resolveGetProductsByVendorUseCase() -> any GetProductsByVendorUseCaseProtocol {
        assembler.resolver.resolve(GetProductsByVendorUseCaseProtocol.self)!
    }

    static func resolveGetProductsUseCase() -> any GetProductsUseCaseProtocol {
        assembler.resolver.resolve(GetProductsUseCaseProtocol.self)!
    }

    @MainActor
    static func resolveHomeViewModel() -> HomeViewModel {
        assembler.resolver.resolve(HomeViewModel.self)!
    }

    @MainActor
    static func resolveShoppingAssistantViewModel() -> ShoppingAssistantViewModel {
        assembler.resolver.resolve(ShoppingAssistantViewModel.self)!
    }
}