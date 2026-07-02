import Checkout
import Foundation

@MainActor
final class HomeFlowCoordinator: ObservableObject {
    // Home owns the routes started from the Home tab, including Product Info -> Cart.
    @Published var path: [HomeFlowRoute] = []

    func showProductInfo(productID: String) {
        path.append(.shared(.productInfo(productID)))
    }

    func showRoot() {
        path = []
    }
}
