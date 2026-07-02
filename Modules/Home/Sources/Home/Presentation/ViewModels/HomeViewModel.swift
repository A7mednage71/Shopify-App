import Foundation
import Combine


enum SortOption: String, CaseIterable {
    case featured = "Featured"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"
    case newest = "Newest"

    var displayName: String { rawValue }
}

struct FilterState: Equatable {
    var minPrice: Double?
    var maxPrice: Double?
    var selectedCategories: Set<String> = []
    var inStockOnly: Bool = false
    var selectedVendors: Set<String> = []
    var selectedProductTypes: Set<String> = []
    var selectedTags: Set<String> = []
    var selectedSizes: Set<String> = []
    var selectedColors: Set<String> = []

    var hasActiveFilters: Bool {
        minPrice != nil ||
        maxPrice != nil ||
        !selectedCategories.isEmpty ||
        inStockOnly ||
        !selectedVendors.isEmpty ||
        !selectedProductTypes.isEmpty ||
        !selectedTags.isEmpty ||
        !selectedSizes.isEmpty ||
        !selectedColors.isEmpty
    }

    mutating func reset() {
        minPrice = nil
        maxPrice = nil
        selectedCategories.removeAll()
        inStockOnly = false
        selectedVendors.removeAll()
        selectedProductTypes.removeAll()
        selectedTags.removeAll()
        selectedSizes.removeAll()
        selectedColors.removeAll()
    }
}

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var collections: [Collection] = []
    @Published private(set) var isLoading: Bool = false
    @Published var error: String? = nil

    // MARK: - Search

    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var searchResults: [SearchProduct] = []
    @Published var isSearchLoading: Bool = false
    var originalSearchResults: [SearchProduct] = []

    // MARK: - Trending

    @Published private(set) var trendingProducts: [TrendingProduct] = []
    @Published private(set) var isTrendingLoading: Bool = false

    // MARK: - Special Offers

    @Published private(set) var specialOffers: [OfferProduct] = []
    @Published private(set) var isSpecialOffersLoading: Bool = false
    
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

    // MARK: - Use Cases

    let getCollectionsUseCase: any GetCollectionsUseCaseProtocol
    let searchProductsUseCase: any SearchProductsUseCaseProtocol
    let getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol
    let getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol

    // MARK: - Combine

    var cancellables = Set<AnyCancellable>()

    init(
        getCollectionsUseCase: any GetCollectionsUseCaseProtocol,
        searchProductsUseCase: any SearchProductsUseCaseProtocol,
        getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol,
        getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol
    ) {
        self.getCollectionsUseCase = getCollectionsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        self.getTrendingProductsUseCase = getTrendingProductsUseCase
        self.getSpecialOffersUseCase = getSpecialOffersUseCase
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
        }
    }
}
