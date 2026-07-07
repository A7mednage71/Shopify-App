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
            "Home"
        case .cart:
            "Cart"
        case .favorites:
            "Favorites"
        case .profile:
            "Profile"
        }
        return ""
    }

    var systemImage: String {
        switch self {
        case .home:
            "house"
        case .cart:
            "cart"
        case .favorites:
            "heart"
        case .profile:
            "person"
        }
        return ""
    }
}
