import Cart
import Checkout
import ProductInfo
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
        cart: CartDetails,
        onOrderConfirmed: @escaping (CheckoutOrderConfirmationRoute) -> Void
    ) -> some View {
        FeatureViewFactoryResolver
            .resolve(CheckoutViewFactory.self)
            .makeCheckoutDestinationView(cart: cart, onOrderConfirmed: onOrderConfirmed)
    }

    @MainActor
    static func makeOrderConfirmationView(
        route: CheckoutOrderConfirmationRoute
    ) -> some View {
        FeatureViewFactoryResolver
            .resolve(CheckoutViewFactory.self)
            .makeOrderConfirmationDestinationView(route: route)
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
