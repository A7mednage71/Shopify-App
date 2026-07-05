import Cart
import Checkout
import ProductInfo
import SwiftUI
import Swinject
import Settings
import Favorites

final class AppDIContainer {
    static let shared = AppDIContainer()

    private let assembler = Assembler([
        CartDataAssembly(),
        CartDomainAssembly(),
        CartPresentationAssembly(),
        CheckoutPresentationAssembly(),
        ProductInfoDataAssembly(),
        ProductInfoDomainAssembly(),
        ProductInfoPresentationAssembly(),
        SettingsAssembly(),
        FavoritesDataAssembly(),
        FavoritesDomainAssembly(),
        FavoritesPresentationAssembly()
    ])

    private init() {}

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        assembler.resolver.resolve(serviceType)
    }
    
    @MainActor
        func makeSettingsView() -> some View {
            guard let settingsViewFactory = assembler.resolver.resolve(SettingsViewFactory.self) else {
                return AnyView(Text("Unable to load settings."))
            }

            return AnyView(settingsViewFactory.makeSettingsView())
        }
}
