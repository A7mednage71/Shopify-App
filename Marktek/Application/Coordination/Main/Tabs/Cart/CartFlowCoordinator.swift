import Checkout
import Common
import Foundation

@MainActor
final class CartFlowCoordinator: ObservableObject {
    // Cart owns the routes started from the Cart tab root.
    @Published var path: [CartFlowRoute] = []
    @Published var orderConfirmation: CheckoutOrderConfirmation?

    func showProductDetails(for productID: String) {
        path.append(.shared(.productInfo(productID)))
    }

    func showCheckout() {
        path = [.checkout]
    }

    func showOrderConfirmation(_ confirmation: CheckoutOrderConfirmation) {
        orderConfirmation = confirmation
        path = [.checkout, .orderConfirmation(confirmation.id)]
    }

    func showRoot() {
        orderConfirmation = nil
        path = []
    }

    func handlePathChange(_ path: [CartFlowRoute]) {
        guard orderConfirmation != nil,
              !path.contains(where: \.isOrderConfirmation) else { return }

        orderConfirmation = nil
        self.path = []
    }
}
