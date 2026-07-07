import Cart
import Checkout
import Common
import ProductInfo
import Orders
import SwiftUI

struct MainFlowView: View {
    @StateObject private var coordinator = MainFlowCoordinator()
    @StateObject private var homeCoordinator = HomeFlowCoordinator()
    @StateObject private var cartCoordinator = CartFlowCoordinator()
    @StateObject private var favoritesCoordinator = FavoritesFlowCoordinator()
    @StateObject private var profileCoordinator = ProfileFlowCoordinator()

    @State private var showAssistant = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    homeToolbarItems
                }
            }
            .onChange(of: cartCoordinator.path) { newPath in
                cartCoordinator.handlePathChange(newPath)
            }

            GlobalFloatingAssistantButton(onTap: {
                showAssistant = true
            })
        }
        .sheet(isPresented: $showAssistant) {
            HomeFlowView.makeShoppingAssistantView(onProductTap: handleProductTapFromAssistant)
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
            ProfileFlowView(onOrdersTap: profileCoordinator.showOrders)
        }
    }

    private var tabs: [MainTab] {
        [.home, .cart, .favorites, .profile]
    }

    private var shouldShowHomeToolbar: Bool {
        coordinator.selectedTab == .home && homeCoordinator.path.isEmpty
    }

    @ToolbarContentBuilder
    private var homeToolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if shouldShowHomeToolbar {
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.appTextPrimary)
                        .font(.system(size: 18))
                }
            }
        }

        ToolbarItem(placement: .principal) {
            if shouldShowHomeToolbar {
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .foregroundColor(.appPrimaryOrange)
                        .font(.system(size: 20))
                    Text("Marktek")
                        .font(.appBarTitle)
                        .foregroundColor(.appPrimaryOrange)
                }
            }
        }

        ToolbarItem(placement: .navigationBarTrailing) {
            if shouldShowHomeToolbar {
                Button(action: {}) {
                    AsyncImage(url: URL(string: "https://i.pravatar.cc/40")) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.appTextTertiary)
                    }
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.appPrimaryOrange, lineWidth: 1.5))
                }
            }
        }
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

        case .profile(let route):
            profileDestination(for: route)
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
            CheckoutViewFactory.makeView(onOrderConfirmed: showOrderConfirmation)

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
    private func profileDestination(for route: ProfileFlowRoute) -> some View {
        switch route {
        case .orders:
            OrdersViewFactory.makeView(onOrderTap: profileCoordinator.showOrderDetails(orderID:))
        case .orderDetails(let orderID):
            OrdersViewFactory.makeDetailsView(orderID: orderID)
        }
    }

    @ViewBuilder
    private func sharedDestination(for route: SharedFlowRoute) -> some View {
        switch route {
        case .productInfo(let productID):
            ProductInfoViewFactory.makeView(
                productID: productID,
                onCartTap: showCartRoot,
                onProductTap: showProductInfoOnActiveTab(productID:)
            )
        }
    }

    private var temporaryProductID: String {
        "gid://shopify/Product/7471719088183"
    }

    @ViewBuilder
    private var cartOrderConfirmationDestination: some View {
        if let confirmation = cartCoordinator.orderConfirmation {
            CheckoutViewFactory.makeOrderConfirmationView(
                confirmation: confirmation,
                onDone: resetAllRoutesToHome
            )
        } else {
            EmptyView()
        }
    }

    private func showOrderConfirmation(_ confirmation: CheckoutOrderConfirmation) {
        homeCoordinator.showRoot()
        cartCoordinator.showOrderConfirmation(confirmation)
        favoritesCoordinator.showRoot()
        profileCoordinator.showRoot()
    }

    private func resetAllRoutesToHome() {
        homeCoordinator.showRoot()
        cartCoordinator.showRoot()
        favoritesCoordinator.showRoot()
        profileCoordinator.showRoot()
        coordinator.showHome()
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

    private func showProductInfoOnActiveTab(productID: String) {
        switch coordinator.selectedTab {
        case .home:
            homeCoordinator.showProductInfo(productID: productID)
        case .cart:
            cartCoordinator.showProductDetails(for: productID)
        case .favorites:
            favoritesCoordinator.showProductInfo(productID: productID)
        case .profile:
            break
        }
    }


    private func handleProductTapFromAssistant(productID: String) {
        showAssistant = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            switch coordinator.selectedTab {
            case .home:
                homeCoordinator.showProductInfo(productID: productID)
            case .cart:
                cartCoordinator.showProductDetails(for: productID)
            case .favorites:
                favoritesCoordinator.showProductInfo(productID: productID)
            case .profile:
                coordinator.showHome()
                homeCoordinator.showProductInfo(productID: productID)
            }
        }
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


