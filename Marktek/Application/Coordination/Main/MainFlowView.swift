import Cart
import Checkout
import ProductInfo
import SwiftUI

struct MainFlowView: View {
    @StateObject private var coordinator = MainFlowCoordinator()
    @StateObject private var homeCoordinator = HomeFlowCoordinator()
    @StateObject private var cartCoordinator = CartFlowCoordinator()
    @StateObject private var favoritesCoordinator = FavoritesFlowCoordinator()
    @StateObject private var profileCoordinator = ProfileFlowCoordinator()

    var body: some View {
        NavigationStack(path: activeRouter) {
            TabView(selection: $coordinator.selectedTab) {
                ForEach(tabs, id: \.self) { tab in
                    contentView(for: tab)
                        .tabItem {
                            Label(tab.title, systemImage: tab.systemImage)
                        }
                        .tag(tab)
                }
            }
            .navigationDestination(for: MainFlowRoute.self) { route in
                destination(for: route)
            }
        }
        .onChange(of: cartCoordinator.path) { newPath in
            cartCoordinator.handlePathChange(newPath)
        }
    }

    @ViewBuilder
    private func contentView(for tab: MainTab) -> some View {
        switch tab {
        case .home:
            HomeFlowView(
                onProductDetailsTap: homeCoordinator.showProductInfo(productID:)
            )

        case .cart:
            CartFlowView(
                onCheckoutTap: { _ in cartCoordinator.showCheckout() },
                onStartShoppingTap: showHomeRoot,
                onProductTap: cartCoordinator.showProductDetails
            )

        case .favorites:
            FavoritesFlowView(
                    onProductDetailsTap: favoritesCoordinator.showProductInfo(productID:)
                )

        case .profile:
            ProfileFlowView()
        }
    }

    private var tabs: [MainTab] {
        [.home, .cart, .favorites, .profile]
    }

    private var activeRouter: Binding<[MainFlowRoute]> {
        Binding(
            get: {
                switch coordinator.selectedTab {
                case .home:
                    homeCoordinator.path.map(MainFlowRoute.home)
                case .cart:
                    cartCoordinator.path.map(MainFlowRoute.cart)
                case .favorites:
                    favoritesCoordinator.path.map(MainFlowRoute.favorites)
                case .profile:
                    profileCoordinator.path.map(MainFlowRoute.profile)
                }
            },
            set: { routes in
                switch coordinator.selectedTab {
                case .home:
                    homeCoordinator.path = routes.compactMap(\.homeRoute)
                case .cart:
                    cartCoordinator.path = routes.compactMap(\.cartRoute)
                case .favorites:
                    favoritesCoordinator.path = routes.compactMap(\.favoritesRoute)
                case .profile:
                    profileCoordinator.path = routes.compactMap(\.profileRoute)
                }
            }
        )
    }

    @ViewBuilder
    private func destination(for route: MainFlowRoute) -> some View {
        switch route {
        case .home(let route):
            homeDestination(for: route)

        case .cart(let route):
            cartDestination(for: route)

        case .favorites(let route):
            favoritesDestination(for: route)

        case .profile:
            EmptyView()
        }
    }

    @ViewBuilder
    private func homeDestination(for route: HomeFlowRoute) -> some View {
        switch route {
        case .shared(let sharedRoute):
            sharedDestination(for: sharedRoute)
        }
    }

    @ViewBuilder
    private func cartDestination(for route: CartFlowRoute) -> some View {
        switch route {
        case .shared(let sharedRoute):
            sharedDestination(for: sharedRoute)

        case .checkout:
            CheckoutViewFactory.makeView { route in
                cartCoordinator.showOrderConfirmation(route)
            }

        case .orderConfirmation:
            cartOrderConfirmationDestination
        }
    }

    @ViewBuilder
    private func favoritesDestination(for route: FavoritesFlowRoute) -> some View {
        switch route {
        case .shared(let sharedRoute):
            sharedDestination(for: sharedRoute)
        }
    }

    @ViewBuilder
    private func sharedDestination(for route: SharedFlowRoute) -> some View {
        switch route {
        case .productInfo(let productID):
            ProductInfoViewFactory.makeView(
                productID: productID,
                onCartTap: showCartRoot
            )
        }
    }

    @ViewBuilder
    private var cartOrderConfirmationDestination: some View {
        if let confirmation = cartCoordinator.orderConfirmation {
            CheckoutViewFactory.makeOrderConfirmationView(confirmation: confirmation)
        } else {
            EmptyView()
        }
    }

    private var temporaryProductID: String {
        "gid://shopify/Product/7471719088183"
    }

    private func showHomeRoot() {
        cartCoordinator.showRoot()
        homeCoordinator.showRoot()
        coordinator.showHome()
    }

    private func showCartRoot() {
        cartCoordinator.showRoot()
        coordinator.showCart()
    }
}

private extension MainFlowRoute {
    var homeRoute: HomeFlowRoute? {
        if case .home(let route) = self {
            return route
        }

        return nil
    }

    var cartRoute: CartFlowRoute? {
        if case .cart(let route) = self {
            return route
        }

        return nil
    }

    var favoritesRoute: FavoritesFlowRoute? {
        if case .favorites(let route) = self {
            return route
        }

        return nil
    }

    var profileRoute: ProfileFlowRoute? {
        if case .profile(let route) = self {
            return route
        }

        return nil
    }
}
