import Foundation




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


extension HomeViewModel {

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

    func extractFilterOptions(from products: [ShopProduct]) {
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
}
