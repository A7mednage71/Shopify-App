import SwiftUI

struct ProductInfoView: View {
    @StateObject private var viewModel: ProductInfoViewModel
    private let productID: String
    private let onCartTap: () -> Void
    private let onProductTap: (String) -> Void

    init(
        productID: String,
        viewModel: ProductInfoViewModel,
        onCartTap: @escaping () -> Void,
        onProductTap: @escaping (String) -> Void
    ) {
        self.productID = productID
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onCartTap = onCartTap
        self.onProductTap = onProductTap
    }

    var body: some View {
        content
        .task {
            await viewModel.loadProduct(id: productID)
        }
    }

    private var content: some View {
        ProductInfoStateContentView(
            state: viewModel.state,
            addToCartState: viewModel.addToCartState,
            comparisonViewModel: viewModel.comparisonViewModel,
            isFavorite: viewModel.isFavorite,
                onFavoriteTap: { product in
                    Task {
                        await viewModel.toggleFavorite(product: product)
                    }
                },
            onCartTap: onCartTap,
            onAddToCart: { variant, quantity in
                Task {
                    await viewModel.addToCart(variant: variant, quantity: quantity)
                }
            },
            onProductTap: onProductTap,
            onRetry: {
                Task {
                    await viewModel.loadProduct(id: productID)
                }
            }
        )
        .productNavigationTitleStyle()
    }
}

private extension View {
    func productNavigationTitleStyle() -> some View {
        navigationBarTitleDisplayMode(.inline)
    }
}
