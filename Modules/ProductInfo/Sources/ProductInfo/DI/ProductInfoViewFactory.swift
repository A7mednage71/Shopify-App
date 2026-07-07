import SwiftUI

public struct ProductInfoViewFactory {
    private let viewModelFactory: ProductInfoViewModelFactory

    init(viewModelFactory: ProductInfoViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    @MainActor
    public func makeProductInfoView(
        productID: String,
        onCartTap: @escaping () -> Void,
        onProductTap: @escaping (String) -> Void = { _ in },
        performProtectedAction: @escaping (@escaping () -> Void) -> Void = { action in action() }
    ) -> some View {
        ProductInfoView(
            productID: productID,
            viewModel: viewModelFactory.makeViewModel(),
            onCartTap: onCartTap,
            onProductTap: onProductTap,
            performProtectedAction: performProtectedAction
        )
    }
}
