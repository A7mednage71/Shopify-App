import Common
import SwiftUI

public struct CheckoutViewFactory {
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider
    private let performCheckoutUseCase: any PerformCheckoutUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider,
        performCheckoutUseCase: any PerformCheckoutUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.paymentStrategyProvider = paymentStrategyProvider
        self.performCheckoutUseCase = performCheckoutUseCase
    }

    @MainActor
    public func makeCheckoutDestinationView() -> some View {
        CheckoutView(
            viewModel: CheckoutViewModel(
                getCurrentCartUseCase: getCurrentCartUseCase,
                paymentStrategyProvider: paymentStrategyProvider,
                performCheckoutUseCase: performCheckoutUseCase
            )
        )
    }
}
