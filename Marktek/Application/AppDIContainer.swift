import Address
import Authentication
import Cart
import Checkout
import ProductInfo
import Swinject
import Settings
import Favorites
import Orders


@MainActor
final class AppDIContainer {
    static let shared = AppDIContainer()

    private let assembler = Assembler([
        NetworkingAssembly(),
        CartDataAssembly(),
        CartDomainAssembly(),
        CartPresentationAssembly(),
        CheckoutPresentationAssembly(),
        AuthAssembly(),
        ProductInfoDataAssembly(),
        ProductInfoDomainAssembly(),
        ProductInfoPresentationAssembly(),
        SettingsAssembly(),
        FavoritesDataAssembly(),
        FavoritesDomainAssembly(),
        FavoritesPresentationAssembly(),
        AddressAssembly(),
        OrdersDataAssembly(),
        OrdersDomainAssembly(),
        OrdersPresentationAssembly()
    ])

    private init() {}

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        assembler.resolver.resolve(serviceType)
    }
}
