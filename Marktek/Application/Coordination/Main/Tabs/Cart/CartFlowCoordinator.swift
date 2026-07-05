import Checkout
import Common
import Foundation

@MainActor
final class CartFlowCoordinator: ObservableObject {
    // Cart owns the routes started from the Cart tab root.
    @Published var path: [CartFlowRoute] = []
    @Published var orderConfirmationRoute: CheckoutOrderConfirmationRoute?
    
    // Store the cart details when proceeding to checkout
    var checkoutCart: CartDetails?

    func showProductDetails(for productID: String) {
        path.append(.shared(.productInfo(productID)))
    }

    func showCheckout(cart: CartDetails) {
        self.checkoutCart = cart
        path = [.checkout]
    }

    func showOrderConfirmation(_ route: CheckoutOrderConfirmationRoute) {
        orderConfirmationRoute = route
        path = [.checkout, .orderConfirmation(route.id)]
    }

    func showRoot() {
        orderConfirmationRoute = nil
        checkoutCart = nil
        path = []
    }
    
    func handlePathChange(_ path: [CartFlowRoute]) {
        guard orderConfirmationRoute != nil,
              !path.contains(where: \.isOrderConfirmation) else { return }

        // Leaving confirmation should return the cart tab to its root cart screen.
        orderConfirmationRoute = nil
        checkoutCart = nil
        self.path = []
    }
}
