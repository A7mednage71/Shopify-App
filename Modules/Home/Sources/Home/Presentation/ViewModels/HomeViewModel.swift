import Foundation
import Combine


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

    // MARK: - Use Cases

    let getCollectionsUseCase: any GetCollectionsUseCaseProtocol
    let searchProductsUseCase: any SearchProductsUseCaseProtocol
    let getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol
    let getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol
    let getProductsByVendorUseCase: any GetProductsByVendorUseCaseProtocol

    // MARK: - Combine

    var cancellables = Set<AnyCancellable>()

    init(
        getCollectionsUseCase: any GetCollectionsUseCaseProtocol,
        searchProductsUseCase: any SearchProductsUseCaseProtocol,
        getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol,
        getSpecialOffersUseCase: any GetSpecialOffersUseCaseProtocol,
        getProductsByVendorUseCase: any GetProductsByVendorUseCaseProtocol
    ) {
        self.getCollectionsUseCase = getCollectionsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        self.getTrendingProductsUseCase = getTrendingProductsUseCase
        self.getSpecialOffersUseCase = getSpecialOffersUseCase
        self.getProductsByVendorUseCase = getProductsByVendorUseCase
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
