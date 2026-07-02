import SwiftUI

struct ProductInfoView: View {
    @StateObject private var viewModel: ProductInfoViewModel
    private let productID: String
    private let onCartTap: () -> Void

    init(
        productID: String,
        viewModel: ProductInfoViewModel,
        onCartTap: @escaping () -> Void
    ) {
        self.productID = productID
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onCartTap = onCartTap
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
            onCartTap: onCartTap,
            onAddToCart: { variant, quantity in
                Task {
                    await viewModel.addToCart(variant: variant, quantity: quantity)
                }
            },
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
