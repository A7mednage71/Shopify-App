import Common
import SwiftUI

public struct CheckoutViewFactory {
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.paymentStrategyProvider = paymentStrategyProvider
    }

    @MainActor
    public func makeCheckoutDestinationView() -> some View {
        CheckoutView(
            viewModel: CheckoutViewModel(
                getCurrentCartUseCase: getCurrentCartUseCase,
                paymentStrategyProvider: paymentStrategyProvider
            )
        )
    }
}
