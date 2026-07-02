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
    @Published private(set) var error: String? = nil

    // MARK: - Search

    @Published var searchText: String = ""
    @Published private(set) var isSearching: Bool = false
    @Published private(set) var searchResults: [SearchProduct] = []
    @Published private(set) var isSearchLoading: Bool = false
    private(set) var originalSearchResults: [SearchProduct] = []

    // MARK: - Trending

    @Published private(set) var trendingProducts: [TrendingProduct] = []
    @Published private(set) var isTrendingLoading: Bool = false
    
    // MARK: - Sorting

    @Published var selectedSortOption: SortOption = .featured
    @Published var showSortSheet: Bool = false

    // MARK: - Filtering

    @Published var filterState = FilterState()
    @Published var showFilterSheet: Bool = false
    @Published private(set) var availableVendors: [String] = []
    @Published private(set) var availableProductTypes: [String] = []
    @Published private(set) var availableTags: [String] = []
    @Published var priceBounds: ClosedRange<Double> = 0...2000

    // MARK: - Use Cases

    private let getCollectionsUseCase: any GetCollectionsUseCaseProtocol
    private let searchProductsUseCase: any SearchProductsUseCaseProtocol
    private let getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol

    // MARK: - Combine

    private var cancellables = Set<AnyCancellable>()

    init(
        getCollectionsUseCase: any GetCollectionsUseCaseProtocol,
        searchProductsUseCase: any SearchProductsUseCaseProtocol,
        getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol
    ) {
        self.getCollectionsUseCase = getCollectionsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        self.getTrendingProductsUseCase = getTrendingProductsUseCase
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


    var resultCountLabel: String {
        "\(searchResults.count) results"
    }

    private func performSearch(query: String) {
        Task {
            isSearchLoading = true
            defer { isSearchLoading = false }
            
            do {
                let results = try await searchProductsUseCase.execute(query: query)
                searchResults = results
                originalSearchResults = results
                extractFilterOptions(from: results)
            } catch {
                self.error = error.localizedDescription
                searchResults = []
                originalSearchResults = []
            }
        }
    }
    
    private func extractFilterOptions(from products: [SearchProduct]) {
        // Extract vendors
        let vendors = Set(products.compactMap { $0.vendor })
        availableVendors = Array(vendors).sorted()
        
        // Extract product types
        let productTypes = Set(products.compactMap { $0.productType })
        availableProductTypes = Array(productTypes).sorted()
        
        // Extract tags
        let allTags = Set(products.flatMap { $0.tags })
        availableTags = Array(allTags).sorted()
        
        // Extract prices
        let prices = products.compactMap { Double($0.price.filter { "0123456789.".contains($0) }) }
        if let minP = prices.min(), let maxP = prices.max(), minP < maxP {
            priceBounds = minP...maxP
        } else if let singlePrice = prices.first {
            priceBounds = 0...(singlePrice * 2)
        } else {
            priceBounds = 0...2000
        }
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                let trimmed = query.trimmingCharacters(in: .whitespaces)
                self?.isSearching = !trimmed.isEmpty
                if !trimmed.isEmpty {
                    self?.performSearch(query: trimmed)
                } else {
                    self?.searchResults = []
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Sorting

    func applySort() {
        if selectedSortOption == .featured {
            searchResults = originalSearchResults
        } else {
            searchResults = sortProducts(originalSearchResults, by: selectedSortOption)
        }
    }

    // MARK: - Filtering

    func applyFilter() {
        var filtered = originalSearchResults

        // Price filter
        if let minPrice = filterState.minPrice {
            filtered = filtered.filter { product in
                let price = Double(product.price.filter { "0123456789.".contains($0) }) ?? 0
                return price >= minPrice
            }
        }
        if let maxPrice = filterState.maxPrice {
            filtered = filtered.filter { product in
                let price = Double(product.price.filter { "0123456789.".contains($0) }) ?? 0
                return price <= maxPrice
            }
        }

        // In stock filter
        if filterState.inStockOnly {
            filtered = filtered.filter { $0.availableForSale }
        }

        // Vendor filter
        if !filterState.selectedVendors.isEmpty {
            filtered = filtered.filter { product in
                guard let vendor = product.vendor else { return false }
                return filterState.selectedVendors.contains(vendor)
            }
        }

        // Product type filter
        if !filterState.selectedProductTypes.isEmpty {
            filtered = filtered.filter { product in
                guard let productType = product.productType else { return false }
                return filterState.selectedProductTypes.contains(productType)
            }
        }

        // Tags filter
        if !filterState.selectedTags.isEmpty {
            filtered = filtered.filter { product in
                return !Set(product.tags).isDisjoint(with: filterState.selectedTags)
            }
        }

        // Size filter (from options)
        if !filterState.selectedSizes.isEmpty {
            filtered = filtered.filter { product in
                return product.options.contains { option in
                    option.name.lowercased() == "size" && !Set(option.values).isDisjoint(with: filterState.selectedSizes)
                }
            }
        }

        // Color filter (from options)
        if !filterState.selectedColors.isEmpty {
            filtered = filtered.filter { product in
                return product.options.contains { option in
                    option.name.lowercased() == "color" && !Set(option.values).isDisjoint(with: filterState.selectedColors)
                }
            }
        }

        searchResults = filtered
    }

    func resetFilters() {
        filterState.reset()
        searchResults = originalSearchResults
    }
    
    private func sortProducts(_ products: [SearchProduct], by option: SortOption) -> [SearchProduct] {
        switch option {
        case .featured:
            return products
        case .priceLowToHigh:
            return products.sorted { product1, product2 in
                let price1 = Double(product1.price.filter { "0123456789.".contains($0) }) ?? 0
                let price2 = Double(product2.price.filter { "0123456789.".contains($0) }) ?? 0
                return price1 < price2
            }
        case .priceHighToLow:
            return products.sorted { product1, product2 in
                let price1 = Double(product1.price.filter { "0123456789.".contains($0) }) ?? 0
                let price2 = Double(product2.price.filter { "0123456789.".contains($0) }) ?? 0
                return price1 > price2
            }
        case .newest:
            return products.reversed()
        }
    }
}
