import Cart
import Checkout
import ProductInfo
import Swinject
import Settings
import Favorites

final class AppDIContainer {
    static let shared = AppDIContainer()

    private let assembler = Assembler([
        NetworkingAssembly(),
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
}
