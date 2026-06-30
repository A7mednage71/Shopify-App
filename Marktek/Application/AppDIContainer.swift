import Cart
import ProductInfo
import SwiftUI
import Swinject

final class AppDIContainer {
    private let assembler = Assembler([
        CartDataAssembly(),
        CartDomainAssembly(),
        CartPresentationAssembly(),
        ProductInfoDataAssembly(),
        ProductInfoDomainAssembly(),
        ProductInfoPresentationAssembly()
    ])

    @MainActor
    func makeRootView() -> some View {
        guard let viewFactory = assembler.resolver.resolve(ProductInfoViewFactory.self) else {
            return AnyView(Text("Unable to load cart."))
        }
        return AnyView(viewFactory.makeProductInfoView(productID: "gid://shopify/Product/7471719088183", ))
//        guard let viewFactory = assembler.resolver.resolve(CartViewFactory.self) else {
//            return AnyView(Text("Unable to load cart."))
//        }
//
//        return AnyView(viewFactory.makeCartView())
    }
}
