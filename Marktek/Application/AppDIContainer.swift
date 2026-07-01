import Cart
import Checkout
import ProductInfo
import SwiftUI
import Swinject

final class AppDIContainer {
    private let assembler = Assembler([
        CartDataAssembly(),
        CartDomainAssembly(),
        CartPresentationAssembly(),
        CheckoutPresentationAssembly(),
        ProductInfoDataAssembly(),
        ProductInfoDomainAssembly(),
        ProductInfoPresentationAssembly()
    ])

    @MainActor
    func makeRootView() -> some View {
        guard let productInfoViewFactory = assembler.resolver.resolve(ProductInfoViewFactory.self),
              let cartViewFactory = assembler.resolver.resolve(CartViewFactory.self),
              let checkoutViewFactory = assembler.resolver.resolve(CheckoutViewFactory.self) else {
            return AnyView(Text("Unable to load cart."))
        }

        return AnyView(
            productInfoViewFactory.makeProductInfoView(
                productID: "gid://shopify/Product/7471719088183",
                cartDestination: {
                    AnyView(
                        cartViewFactory.makeCartDestinationView(
                            checkoutDestination: {
                                AnyView(checkoutViewFactory.makeCheckoutDestinationView())
                            }
                        )
                    )
                }
            )
        )
    }
}
