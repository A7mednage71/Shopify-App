import Common
import Swinject

public struct CheckoutPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CheckoutPaymentStrategyProvider.self) { _ in
            CheckoutPaymentStrategyProvider()
        }

        container.register(PerformCheckoutUseCaseProtocol.self) { resolver in
            PerformCheckoutUseCase(
                paymentStrategyProvider: resolver.resolve(CheckoutPaymentStrategyProvider.self)!
            )
        }

        container.register(CheckoutRemoteDataSource.self) { _ in
            ShopifyCheckoutRemoteDataSource()
        }

        container.register(CheckoutRepository.self) { resolver in
            CheckoutRepositoryImpl(
                remoteDataSource: resolver.resolve(CheckoutRemoteDataSource.self)!
            )
        }

        container.register(CreateDraftOrderUseCaseProtocol.self) { resolver in
            CreateDraftOrderUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!
            )
        }

        container.register(ApplyDraftOrderDiscountUseCaseProtocol.self) { resolver in
            ApplyDraftOrderDiscountUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!
            )
        }

        container.register(CompleteDraftOrderUseCaseProtocol.self) { resolver in
            CompleteDraftOrderUseCase(
                repository: resolver.resolve(CheckoutRepository.self)!
            )
        }

        container.register(CheckoutViewModelFactory.self) { resolver in
            CheckoutViewModelFactory(
                paymentStrategyProvider: resolver.resolve(CheckoutPaymentStrategyProvider.self)!,
                performCheckoutUseCase: resolver.resolve(PerformCheckoutUseCaseProtocol.self)!,
                createDraftOrderUseCase: resolver.resolve(CreateDraftOrderUseCaseProtocol.self)!,
                applyDraftOrderDiscountUseCase: resolver.resolve(ApplyDraftOrderDiscountUseCaseProtocol.self)!,
                completeDraftOrderUseCase: resolver.resolve(CompleteDraftOrderUseCaseProtocol.self)!
            )
        }

        container.register(CheckoutViewFactory.self) { resolver in
            CheckoutViewFactory(
                viewModelFactory: resolver.resolve(CheckoutViewModelFactory.self)!
            )
        }
    }
}
