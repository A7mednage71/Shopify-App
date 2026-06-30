import SwiftUI

struct ProductInfoView: View {
    @StateObject private var viewModel: ProductInfoViewModel
    private let productID: String
    private let cartDestination: () -> AnyView

    init(
        productID: String,
        viewModel: ProductInfoViewModel,
        cartDestination: @escaping () -> AnyView
    ) {
        self.productID = productID
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.cartDestination = cartDestination
    }

    var body: some View {
        NavigationView {
            ProductInfoStateContentView(
                state: viewModel.state,
                addToCartState: viewModel.addToCartState,
                cartDestination: cartDestination,
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
        .productNavigationContainerStyle()
        .task {
            await viewModel.loadProduct(id: productID)
        }
    }
}

private extension View {
    func productNavigationTitleStyle() -> some View {
        navigationBarTitleDisplayMode(.inline)
    }

    func productNavigationContainerStyle() -> some View {
        navigationViewStyle(.stack)
    }
}
