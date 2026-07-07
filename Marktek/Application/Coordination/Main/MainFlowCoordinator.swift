import SwiftUI

@MainActor
final class MainFlowCoordinator: ObservableObject {
    @Published var selectedTab: MainTab = .home

    func showHome() {
        selectedTab = .home
    }

    func showCart() {
        selectedTab = .cart
    }
}

enum MainTab: Hashable {
    case home
    case cart
    case favorites
    case profile

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .cart:
            return "Cart"
        case .favorites:
            return "Favorites"
        case .profile:
            return "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .cart:
            return "cart"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
}
