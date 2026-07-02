import SwiftUI

public struct CartViewFactory {
    private let viewModelFactory: CartViewModelFactory

    init(viewModelFactory: CartViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    @MainActor
    public func makeCartDestinationView(
        onCheckoutTap: @escaping () -> Void,
        onStartShoppingTap: @escaping () -> Void,
        onProductTap: @escaping (String) -> Void
    ) -> some View {
        CartDetailsView(
            viewModel: viewModelFactory.makeViewModel(),
            onCheckoutTap: onCheckoutTap,
            onStartShoppingTap: onStartShoppingTap,
            onProductTap: onProductTap
        )
    }
}
