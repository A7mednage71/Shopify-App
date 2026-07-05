import Cart
import Checkout
import ProductInfo
import SwiftUI
import Swinject

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
        ProductInfoPresentationAssembly()
    ])

    private init() {}

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        assembler.resolver.resolve(serviceType)
    }
}
