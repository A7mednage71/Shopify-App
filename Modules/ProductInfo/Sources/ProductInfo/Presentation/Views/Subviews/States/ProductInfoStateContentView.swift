import SwiftUI

struct ProductInfoStateContentView: View {
    let state: ProductInfoViewState
    let addToCartState: ProductInfoAddToCartState
    let cartDestination: () -> AnyView
    let onAddToCart: (ProductVariant?, Int) -> Void
    let onRetry: () -> Void

    var body: some View {
        switch state {
        case .idle, .loading:
            ProductInfoLoadingView()

        case .success(let product):
            ProductInfoContentView(
                product: product,
                addToCartState: addToCartState,
                cartDestination: cartDestination,
                onAddToCart: onAddToCart
            )

        case .failure(let message):
            ProductInfoErrorView(message: message, onRetry: onRetry)
        }
    }
}
