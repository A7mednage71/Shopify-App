import Foundation
import Combine
import Favorites


@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var collections: [Collection] = []
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
    // MARK: - Use Cases

    let getCollectionsUseCase: any GetCollectionsUseCaseProtocol
    let searchProductsUseCase: any SearchProductsUseCaseProtocol
    let getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol
    let getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol
    let getProductsByVendorUseCase: any GetProductsByVendorUseCaseProtocol
    let manageFavoritesUseCase: any ManageFavoritesUseCase
    // MARK: - Combine

    var cancellables = Set<AnyCancellable>()

    init(
        getCollectionsUseCase: any GetCollectionsUseCaseProtocol,
        searchProductsUseCase: any SearchProductsUseCaseProtocol,
        getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol,
        getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol,
        getProductsByVendorUseCase: any GetProductsByVendorUseCaseProtocol,
        manageFavoritesUseCase: any ManageFavoritesUseCase
    ) {
        self.getCollectionsUseCase = getCollectionsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        self.getTrendingProductsUseCase = getTrendingProductsUseCase
        self.getSpecialOffersUseCase = getSpecialOffersUseCase
        self.getProductsByVendorUseCase = getProductsByVendorUseCase
        self.manageFavoritesUseCase = manageFavoritesUseCase
        bindSearch()
    }


    func loadCollections() async {
        isLoading = true
        error = nil
        do {
            collections = try await getCollectionsUseCase.execute(first: 20)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    func loadTrendingProducts() async {
        isTrendingLoading = true
        do {
            trendingProducts = try await getTrendingProductsUseCase.execute(first: 20)
        } catch {
            self.error = error.localizedDescription
        }
        isTrendingLoading = false
    }

    func loadSpecialOffers() async {
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
            await loadCollections()
            await loadTrendingProducts()
            await loadSpecialOffers()
            await loadFavorites()
        }
    }
    // MARK: - Favorites Logic

        public func loadFavorites() async {
            do {
                let favorites = try await manageFavoritesUseCase.fetchFavorites()
                self.favoriteProductIDs = Set(favorites.map { $0.id })
            } catch {
                print("Error loading favorites in Home: \(error.localizedDescription)")
            }
        }
        
        public func toggleFavorite(for product: HomeProduct) async {
            let price = Double(product.price) ?? 0.0
            
            var finalComparePrice: Double? = nil
            if let compareAtStr = product.compareAtPrice, let compareAtDbl = Double(compareAtStr), compareAtDbl > 0 {
                finalComparePrice = compareAtDbl
            }
            
            let favoriteItem = FavoriteProduct(
                id: product.id,
                title: product.title,
                imageURL: product.featuredImageURL ?? "", 
                price: price,
                currencyCode: product.currencyCode,
                compareAtPrice: finalComparePrice
            )
            
            await executeToggle(for: favoriteItem)
        }
        
        public func toggleFavorite(for product: ShopProduct) async {
            let price = Double(product.price) ?? 0.0
            
            var finalComparePrice: Double? = nil
            if let compareAt = product.compareAtPrice, let compareAtDbl = Double(compareAt), compareAtDbl > 0 {
                finalComparePrice = compareAtDbl
            }
            
            let favoriteItem = FavoriteProduct(
                id: product.id,
                title: product.title,
                imageURL: product.featuredImageURL ?? "", 
                price: price,
                currencyCode: product.currencyCode,
                compareAtPrice: finalComparePrice
            )
            
            await executeToggle(for: favoriteItem)
        }
        private func executeToggle(for favoriteItem: FavoriteProduct) async {
            do {
                try await manageFavoritesUseCase.toggleFavorite(product: favoriteItem)
                
                if favoriteProductIDs.contains(favoriteItem.id) {
                    favoriteProductIDs.remove(favoriteItem.id)
                } else {
                    favoriteProductIDs.insert(favoriteItem.id)
                }
            } catch {
                print("Error toggling favorite in Home: \(error.localizedDescription)")
            }
        }
}
