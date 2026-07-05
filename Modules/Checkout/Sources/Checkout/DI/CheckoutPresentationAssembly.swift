import Common
import Swinject

public struct CheckoutPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CheckoutPaymentStrategyProvider.self) { _ in
            CheckoutPaymentStrategyProvider()
        }

        container.register(CheckoutRemoteDataSource.self) { _ in
            ShopifyCheckoutRemoteDataSource()
        }

        container.register(CheckoutRepository.self) { resolver in
            CheckoutRepositoryImpl(
                remoteDataSource: resolver.resolve(CheckoutRemoteDataSource.self)!
            )
        }
        
        container.register(CreateOrderUseCaseProtocol.self) { resolver in
            CreateOrderUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!
            )
        }

        container.register(GetCustomerDetailsUseCaseProtocol.self) { resolver in
            GetCustomerDetailsUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!
            )
        }

        container.register(CheckoutViewModelFactory.self) { resolver in
            CheckoutViewModelFactory(
                paymentStrategyProvider: resolver.resolve(CheckoutPaymentStrategyProvider.self)!,
                createOrderUseCase: resolver.resolve(CreateOrderUseCaseProtocol.self)!,
                getCustomerDetailsUseCase: resolver.resolve(GetCustomerDetailsUseCaseProtocol.self)!
            )
        }

        container.register(CheckoutViewFactory.self) { resolver in
            CheckoutViewFactory(
                viewModelFactory: resolver.resolve(CheckoutViewModelFactory.self)!
            )
        }
    }
}
