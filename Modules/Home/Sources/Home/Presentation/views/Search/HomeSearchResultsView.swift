import SwiftUI
import Common
import Shimmer

struct HomeSearchResultsView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        Group {
            if viewModel.isSearchLoading {
                SearchResultsSection(
                    products: MockShopifyData.featuredProducts,
                    onProductTap: { _ in }
                )
                .redacted(reason: .placeholder)
                .shimmering()
                .disabled(true)
            } else {
                SearchResultsSection(
                    products: viewModel.searchResults,
                    onProductTap: { product in
                        print("Search result tapped: \(product.title)")
                    }
                )
            }
        }
    }
}
