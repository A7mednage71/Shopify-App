import SwiftUI

public struct CartViewFactory {
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol
    private let removeCartLineUseCase: any RemoveCartLineUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol,
        removeCartLineUseCase: any RemoveCartLineUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.updateCartLineQuantityUseCase = updateCartLineQuantityUseCase
        self.removeCartLineUseCase = removeCartLineUseCase
    }

    @MainActor
    public func makeCartView() -> some View {
        CartDetailsView(
            viewModel: CartViewModel(
                getCurrentCartUseCase: getCurrentCartUseCase,
                updateCartLineQuantityUseCase: updateCartLineQuantityUseCase,
                removeCartLineUseCase: removeCartLineUseCase
            )
        )
    }
}
