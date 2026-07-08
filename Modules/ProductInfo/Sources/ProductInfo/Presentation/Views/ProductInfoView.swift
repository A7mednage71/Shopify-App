import SwiftUI

struct ProductInfoView: View {
    @StateObject private var viewModel: ProductInfoViewModel
    private let productID: String
    private let onCartTap: () -> Void
    private let onProductTap: (String) -> Void
    private let performProtectedAction: (@escaping () -> Void) -> Void

    init(
        productID: String,
        viewModel: ProductInfoViewModel,
        onCartTap: @escaping () -> Void,
        onProductTap: @escaping (String) -> Void,
        performProtectedAction: @escaping (@escaping () -> Void) -> Void = { action in action() }
    ) {
        self.productID = productID
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onCartTap = onCartTap
        self.onProductTap = onProductTap
        self.performProtectedAction = performProtectedAction
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
                performProtectedAction {
                    Task {
                        await viewModel.toggleFavorite(product: product)
                    }
                }
            },
            onCartTap: onCartTap,
            onAddToCart: { variant, quantity in
                performProtectedAction {
                    Task {
                        await viewModel.addToCart(variant: variant, quantity: quantity)
                    }
                }
            },
            onProductTap: onProductTap,
            performProtectedAction: performProtectedAction,
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
