import Cart
import Checkout
import ProductInfo
import Favorites
import SwiftUI

struct MainFlowViewFactory {
    
    @MainActor
    static func makeView() -> MainFlowView {
        MainFlowView()
    }
    
}

private enum FeatureViewFactoryResolver {
    static func resolve<Factory>(_ factoryType: Factory.Type) -> Factory {
        guard let factory = AppDIContainer.shared.resolve(factoryType) else {
            fatalError("Unable to resolve \(factoryType). Check the app DI assemblies.")
        }

        return factory
    }
}

extension CartViewFactory {
    @MainActor
    static func makeView(
        onCheckoutTap: @escaping (CartDetails) -> Void,
        onStartShoppingTap: @escaping () -> Void,
        onProductTap: @escaping (String) -> Void
    ) -> some View {
        FeatureViewFactoryResolver
            .resolve(CartViewFactory.self)
            .makeCartDestinationView(
                onCheckoutTap: onCheckoutTap,
                onStartShoppingTap: onStartShoppingTap,
                onProductTap: onProductTap
            )
    }
}

extension CheckoutViewFactory {
    @MainActor
    static func makeView(
        onOrderConfirmed: @escaping (CheckoutOrderConfirmation) -> Void
    ) -> some View {
        FeatureViewFactoryResolver
            .resolve(CheckoutViewFactory.self)
            .makeCheckoutDestinationView(onOrderConfirmed: onOrderConfirmed)
    }

    @MainActor
    static func makeOrderConfirmationView(
        confirmation: CheckoutOrderConfirmation
    ) -> some View {
        FeatureViewFactoryResolver
            .resolve(CheckoutViewFactory.self)
            .makeOrderConfirmationDestinationView(confirmation: confirmation)
    }
}

extension ProductInfoViewFactory {
    @MainActor
    static func makeView(
        productID: String,
        onCartTap: @escaping () -> Void
    ) -> some View {
        // Product ID is screen data; cart tap remains a coordinator-owned navigation action.
        FeatureViewFactoryResolver
            .resolve(ProductInfoViewFactory.self)
            .makeProductInfoView(
                productID: productID,
                onCartTap: onCartTap
            )
    }
}

extension FavoritesViewFactory {
    @MainActor
    static func makeFavoritesView(
        onProductTap: @escaping (String) -> Void
    ) -> some View {
        FeatureViewFactoryResolver
            .resolve(FavoritesViewFactory.self)
            .makeFavoritesDestinationView(onProductTap: onProductTap)
    }
}
