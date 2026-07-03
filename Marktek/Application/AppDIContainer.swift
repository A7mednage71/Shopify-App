import Cart
import ProductInfo
import SwiftUI
import Swinject
import Settings

final class AppDIContainer {
    private let assembler = Assembler([
        CartDataAssembly(),
        CartDomainAssembly(),
        CartPresentationAssembly(),
        ProductInfoDataAssembly(),
        ProductInfoDomainAssembly(),
        ProductInfoPresentationAssembly(),
        SettingsAssembly()
    ])

    @MainActor
    func makeRootView() -> some View {
        guard let productInfoViewFactory = assembler.resolver.resolve(ProductInfoViewFactory.self),
              let cartViewFactory = assembler.resolver.resolve(CartViewFactory.self) else {
            return AnyView(Text("Unable to load cart."))
        }

        return AnyView(
            productInfoViewFactory.makeProductInfoView(
                productID: "gid://shopify/Product/7471719088183",
                cartDestination: {
                    AnyView(cartViewFactory.makeCartDestinationView())
                }
            )
        )
    }
    
    @MainActor
        func makeSettingsView() -> some View {
            guard let settingsViewFactory = assembler.resolver.resolve(SettingsViewFactory.self) else {
                return AnyView(Text("Unable to load settings."))
            }

            return AnyView(settingsViewFactory.makeSettingsView())
        }
}
