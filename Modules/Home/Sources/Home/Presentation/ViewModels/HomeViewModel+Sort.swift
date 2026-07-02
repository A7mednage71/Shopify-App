import Foundation

extension HomeViewModel {

    func applySort() {
        if selectedSortOption == .featured {
            searchResults = originalSearchResults
        } else {
            searchResults = sortProducts(originalSearchResults, by: selectedSortOption)
        }
    }

    func sortProducts(_ products: [SearchProduct], by option: SortOption) -> [SearchProduct] {
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
