import Common
import Swinject

public struct CheckoutPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CustomerAccessTokenDataSource.self) { _ in
            DummyCustomerAccessTokenDataSource()
        }

        container.register(CheckoutRemoteDataSource.self) { resolver in
            ShopifyCheckoutRemoteDataSource(
                customerAccessTokenDataSource: resolver.resolve(CustomerAccessTokenDataSource.self)!
            )
        }

        container.register(CheckoutRepository.self) { resolver in
            CheckoutRepositoryImpl(
                remoteDataSource: resolver.resolve(CheckoutRemoteDataSource.self)!
            )
        }

        container.register(CheckoutPaymentStrategyProvider.self) { _ in
            CheckoutPaymentStrategyProvider()
        }

        container.register(CheckoutPricingUseCaseProtocol.self) { resolver in
            CheckoutPricingUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!
            )
        }

        container.register(CheckoutPaymentAuthorizing.self) { _ in
            ApplePayPaymentAuthorizer()
        }

        container.register(CreateOrderUseCaseProtocol.self) { resolver in
            CreateOrderUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!,
                paymentStrategyProvider: resolver.resolve(CheckoutPaymentStrategyProvider.self)!,
                checkoutPricingUseCase: resolver.resolve(CheckoutPricingUseCaseProtocol.self)!
            )
        }

        container.register(GetCustomerDetailsUseCaseProtocol.self) { resolver in
            GetCustomerDetailsUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!
            )
        }

        container.register(CheckoutViewModelFactory.self) { resolver in
            CheckoutViewModelFactory(
                getCurrentCartUseCase: resolver.resolve(GetCurrentCartUseCaseProtocol.self)!,
                createOrderUseCase: resolver.resolve(CreateOrderUseCaseProtocol.self)!,
                getCustomerDetailsUseCase: resolver.resolve(GetCustomerDetailsUseCaseProtocol.self)!,
                checkoutPricingUseCase: resolver.resolve(CheckoutPricingUseCaseProtocol.self)!,
                paymentAuthorizer: resolver.resolve(CheckoutPaymentAuthorizing.self)!
            )
        }

        container.register(CheckoutViewFactory.self) { resolver in
            CheckoutViewFactory(
                viewModelFactory: resolver.resolve(CheckoutViewModelFactory.self)!
            )
        }
    }
}
