import Common
import Swinject

public struct CheckoutPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CheckoutPaymentStrategyProvider.self) { _ in
            CheckoutPaymentStrategyProvider()
        }

        container.register(CheckoutViewFactory.self) { resolver in
            CheckoutViewFactory(
                getCurrentCartUseCase: resolver.resolve(GetCurrentCartUseCaseProtocol.self)!,
                paymentStrategyProvider: resolver.resolve(CheckoutPaymentStrategyProvider.self)!
            )
        }
    }
}
