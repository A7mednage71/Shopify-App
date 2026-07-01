import SwiftUI

public struct CartViewFactory {
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol
    private let removeCartLineUseCase: any RemoveCartLineUseCaseProtocol
    private let applyDiscountCodeUseCase: any ApplyDiscountCodeUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol,
        removeCartLineUseCase: any RemoveCartLineUseCaseProtocol,
        applyDiscountCodeUseCase: any ApplyDiscountCodeUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.updateCartLineQuantityUseCase = updateCartLineQuantityUseCase
        self.removeCartLineUseCase = removeCartLineUseCase
        self.applyDiscountCodeUseCase = applyDiscountCodeUseCase
    }

    @MainActor
    public func makeCartView(checkoutDestination: @escaping () -> AnyView) -> some View {
        NavigationView {
            makeCartDetailsView(checkoutDestination: checkoutDestination)
        }
        .cartNavigationContainerStyle()
    }

    @MainActor
    public func makeCartDestinationView(checkoutDestination: @escaping () -> AnyView) -> some View {
        makeCartDetailsView(checkoutDestination: checkoutDestination)
    }

    @MainActor
    private func makeCartDetailsView(checkoutDestination: @escaping () -> AnyView) -> some View {
        CartDetailsView(
            viewModel: CartViewModel(
                getCurrentCartUseCase: getCurrentCartUseCase,
                updateCartLineQuantityUseCase: updateCartLineQuantityUseCase,
                removeCartLineUseCase: removeCartLineUseCase,
                applyDiscountCodeUseCase: applyDiscountCodeUseCase
            ),
            checkoutDestination: checkoutDestination
        )
    }
}
