import Foundation

enum SortOption: String, CaseIterable {
    case featured = "Featured"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"
    case newest = "Newest"

    var displayName: String { rawValue }
}

extension HomeViewModel {

    func applySort() {
        if selectedSortOption == .featured {
            searchResults = originalSearchResults
        } else {
            searchResults = sortProducts(originalSearchResults, by: selectedSortOption)
        }
    }

    func sortProducts(_ products: [ShopProduct], by option: SortOption) -> [ShopProduct] {
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
