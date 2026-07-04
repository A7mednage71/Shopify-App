import SwiftUI

public struct ProductInfoViewFactory {
    private let viewModelFactory: ProductInfoViewModelFactory

    init(viewModelFactory: ProductInfoViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    @MainActor
    public func makeProductInfoView(
        productID: String,
        onCartTap: @escaping () -> Void
    ) -> some View {
        ProductInfoView(
            productID: productID,
            viewModel: viewModelFactory.makeViewModel(),
            onCartTap: onCartTap
        )
    }
}
