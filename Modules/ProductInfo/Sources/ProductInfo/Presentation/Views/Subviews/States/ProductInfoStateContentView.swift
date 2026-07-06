import SwiftUI

struct ProductInfoStateContentView: View {
    let state: ProductInfoViewState
    let addToCartState: ProductInfoAddToCartState
    @ObservedObject var comparisonViewModel: ProductComparisonViewModel
    let isFavorite: Bool
    let onFavoriteTap: (ProductDetails) -> Void
    let onCartTap: () -> Void
    let onAddToCart: (ProductVariant?, Int) -> Void
    let onProductTap: (String) -> Void
    let onRetry: () -> Void

    var body: some View {
        switch state {
        case .idle, .loading:
            ProductInfoLoadingView()

        case .success(let product):
            ProductInfoContentView(
                product: product,
                addToCartState: addToCartState,
                comparisonViewModel: comparisonViewModel,
                isFavorite: isFavorite,
                onCartTap: onCartTap,
                onAddToCart: onAddToCart,
                onFavoriteTap: { onFavoriteTap(product) },
                onProductTap: onProductTap
            )

        case .failure(let message):
            ProductInfoErrorView(message: message, onRetry: onRetry)
        }
    }
}
