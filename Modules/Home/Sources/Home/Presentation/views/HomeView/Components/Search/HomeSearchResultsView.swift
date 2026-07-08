import SwiftUI
import Common
import Shimmer

struct HomeSearchResultsView: View {
    @ObservedObject var viewModel: HomeViewModel
    var onProductTap: ((ShopProduct) -> Void)? = nil
    var performProtectedAction: (@escaping () -> Void) -> Void = { action in action() }
    
    var body: some View {
        Group {
            if viewModel.isSearchLoading {
                SearchResultsSection(
                    products: MockShopifyData.featuredProducts,
                    onProductTap: { _ in }, favoriteProductIDs: [],
                    onFavoriteTap: { _ in }
                )
                .redacted(reason: .placeholder)
                .shimmering()
                .disabled(true)
            } else {
                SearchResultsSection(
                    products: viewModel.searchResults,
                    onProductTap: { product in 
                        onProductTap?(product)
                    },
                    favoriteProductIDs: viewModel.favoriteProductIDs,
                    onFavoriteTap: { product in
                        performProtectedAction {
                            Task {
                                await viewModel.toggleFavorite(for: product)
                            }
                        }
                    }
                )
            }
        }
    }
}
