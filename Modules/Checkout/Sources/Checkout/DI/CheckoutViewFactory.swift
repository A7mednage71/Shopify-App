import Common
import SwiftUI

public struct CheckoutViewFactory {
    private let viewModelFactory: CheckoutViewModelFactory

    init(viewModelFactory: CheckoutViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    @MainActor
    public func makeCheckoutDestinationView(
        onOrderConfirmed: @escaping (CheckoutOrderConfirmation) -> Void = { _ in }
    ) -> some View {
        // Checkout is a destination screen; completion is reported back to the flow coordinator.
        CheckoutView(
            viewModel: viewModelFactory.makeViewModel(),
            onOrderConfirmed: onOrderConfirmed
        )
    }

    @MainActor
    public func makeOrderConfirmationDestinationView(
        confirmation: CheckoutOrderConfirmation
    ) -> some View {
        // Order confirmation stays Checkout-owned, while the app flow decides when to present it.
        CheckoutOrderConfirmationView(confirmation: confirmation)
    }
}
