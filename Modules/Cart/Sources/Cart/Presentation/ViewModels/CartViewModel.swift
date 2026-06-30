import SwiftUI

@MainActor
public final class CartViewModel: ObservableObject {
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let updateCartLinesUseCase: any UpdateCartLinesUseCaseProtocol
    private let removeCartLinesUseCase: any RemoveCartLinesUseCaseProtocol

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        updateCartLinesUseCase: any UpdateCartLinesUseCaseProtocol,
        removeCartLinesUseCase: any RemoveCartLinesUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.updateCartLinesUseCase = updateCartLinesUseCase
        self.removeCartLinesUseCase = removeCartLinesUseCase
    }
}
