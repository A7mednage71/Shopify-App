import Foundation

@MainActor
final class FavoritesFlowCoordinator: ObservableObject {
    @Published var path: [FavoritesFlowRoute] = []
    func showProductInfo(productID: String) {
            path.append(.shared(.productInfo(productID)))
        }

        func showRoot() {
            path = []
        }
}
