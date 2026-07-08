import Foundation
import Common

enum SortOption: String, CaseIterable {
    case featured = "Featured"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"
    case newest = "Newest"
    var displayName: String {
        switch self {
        case .featured: return L10n.HomeStrs.sortFeatured
        case .priceLowToHigh: return L10n.HomeStrs.sortPriceLowToHigh
        case .priceHighToLow: return L10n.HomeStrs.sortPriceHighToLow
        case .newest: return L10n.HomeStrs.sortNewest
        }
    }
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
