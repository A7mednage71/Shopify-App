import SwiftUI

public enum CartViewFactory {
    @MainActor
    public static func makeCartView() -> some View {
        CartDetailsView(
            viewModel: CartViewModel(
                getCurrentCartUseCase: CartAssembler.resolveGetCurrentCartUseCase(),
                updateCartLinesUseCase: CartAssembler.resolveUpdateCartLinesUseCase(),
                removeCartLinesUseCase: CartAssembler.resolveRemoveCartLinesUseCase()
            )
        )
    }
}
