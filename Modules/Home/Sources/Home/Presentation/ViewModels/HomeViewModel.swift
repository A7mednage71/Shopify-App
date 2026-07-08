import Foundation
import Combine
import Favorites


@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var categories: [Collection] = []
    @Published private(set) var brands: [Collection] = []
    @Published private(set) var isLoading: Bool = false
    @Published var error: String? = nil

    // MARK: - Search

    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var searchResults: [ShopProduct] = []
    @Published var isSearchLoading: Bool = false
    var originalSearchResults: [ShopProduct] = []

    @Published private(set) var trendingProducts: [HomeProduct] = []
    @Published private(set) var isTrendingLoading: Bool = false

    // MARK: - Special Offers

    @Published private(set) var specialOffers: [HomeProduct] = []
    @Published private(set) var isSpecialOffersLoading: Bool = false
    
    // MARK: - Vendor Products

    @Published var vendorProducts: [ShopProduct] = []
    @Published var isVendorProductsLoading: Bool = false
    @Published var vendorProductsError: String? = nil

    // MARK: - Sorting

    @Published var selectedSortOption: SortOption = .featured
    @Published var showSortSheet: Bool = false

    // MARK: - Filtering

    @Published var filterState = FilterState()
    @Published var showFilterSheet: Bool = false
    @Published var availableVendors: [String] = []
    @Published var availableProductTypes: [String] = []
    @Published var availableTags: [String] = []
    @Published var priceBounds: ClosedRange<Double> = 0...2000
    @Published var favoriteProductIDs: Set<String> = []
    
    // MARK: - Alerts
    @Published var productToRemove: Favorites.FavoriteProduct?
    @Published var showingRemoveFavoriteAlert: Bool = false
    
    // MARK: - Use Cases

    let getCategoriesUseCase: any GetCategoriesUseCaseProtocol
    let getBrandsUseCase: any GetBrandsUseCaseProtocol
    let searchProductsUseCase: any SearchProductsUseCaseProtocol
    let getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol
    let getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol
    let getProductsByVendorUseCase: any GetProductsByVendorUseCaseProtocol
    let getProductsByCategoryUseCase: any GetProductsByCategoryUseCaseProtocol
    let manageFavoritesUseCase: any ManageFavoritesUseCase
    // MARK: - Combine

    var cancellables = Set<AnyCancellable>()

    init(
        getCategoriesUseCase: any GetCategoriesUseCaseProtocol,
        getBrandsUseCase: any GetBrandsUseCaseProtocol,
        searchProductsUseCase: any SearchProductsUseCaseProtocol,
        getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol,
        getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol,
        getProductsByVendorUseCase: any GetProductsByVendorUseCaseProtocol,
        getProductsByCategoryUseCase: any GetProductsByCategoryUseCaseProtocol,
        manageFavoritesUseCase: any ManageFavoritesUseCase
    ) {
        self.getCategoriesUseCase = getCategoriesUseCase
        self.getBrandsUseCase = getBrandsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        self.getTrendingProductsUseCase = getTrendingProductsUseCase
        self.getSpecialOffersUseCase = getSpecialOffersUseCase
        self.getProductsByVendorUseCase = getProductsByVendorUseCase
        self.getProductsByCategoryUseCase = getProductsByCategoryUseCase
        self.manageFavoritesUseCase = manageFavoritesUseCase
        bindSearch()
    }


    func loadCollections(force: Bool = false) async {
        guard force || (categories.isEmpty && brands.isEmpty) else { return }
        isLoading = true
        error = nil
        do {
            async let categoriesTask = getCategoriesUseCase.execute(first: 20)
            async let brandsTask = getBrandsUseCase.execute(first: 20)
            
            let (cats, brs) = try await (categoriesTask, brandsTask)
            self.categories = cats
            self.brands = brs
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    func loadTrendingProducts(force: Bool = false) async {
        guard force || trendingProducts.isEmpty else { return }
        isTrendingLoading = true
        do {
            trendingProducts = try await getTrendingProductsUseCase.execute(first: 20)
        } catch {
            self.error = error.localizedDescription
        }
        isTrendingLoading = false
    }

    func loadSpecialOffers(force: Bool = false) async {
        guard force || specialOffers.isEmpty else { return }
        isSpecialOffersLoading = true
        do {
            specialOffers = try await getSpecialOffersUseCase.execute(first: 20)
        } catch {
            self.error = error.localizedDescription
        }
        isSpecialOffersLoading = false
    }

    func retry() {
        Task {
            error = nil
            await loadCollections(force: true)
            await loadTrendingProducts(force: true)
            await loadSpecialOffers(force: true)
            await loadFavorites()
        }
    }
}

