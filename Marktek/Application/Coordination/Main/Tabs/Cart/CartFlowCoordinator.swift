import Checkout
import Foundation

@MainActor
final class CartFlowCoordinator: ObservableObject {
    // Cart owns the routes started from the Cart tab root.
    @Published var path: [CartFlowRoute] = []
    @Published var orderConfirmationRoute: CheckoutOrderConfirmationRoute?

    func showProductDetails(for productID: String) {
        path.append(.shared(.productInfo(productID)))
    }

    func showCheckout() {
        path = [.checkout]
    }

    func showOrderConfirmation(_ route: CheckoutOrderConfirmationRoute) {
        orderConfirmationRoute = route
        path = [.checkout, .orderConfirmation(route.id)]
    }

    func showRoot() {
        orderConfirmationRoute = nil
        path = []
    }
    

    func handlePathChange(_ path: [CartFlowRoute]) {
        guard orderConfirmationRoute != nil,
              !path.contains(where: \.isOrderConfirmation) else { return }

        // Leaving confirmation should return the cart tab to its root cart screen.
        orderConfirmationRoute = nil
        self.path = []
    }
}
