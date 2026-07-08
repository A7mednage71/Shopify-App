import SwiftUI
import Common

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
            return L10n.Main.tabHome
        case .cart:
            return L10n.Main.tabCart
        case .favorites:
            return L10n.Main.tabFavorites
        case .profile:
            return L10n.Main.tabProfile
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
