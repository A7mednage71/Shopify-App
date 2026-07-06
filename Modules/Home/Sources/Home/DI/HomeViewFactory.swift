import SwiftUI

public enum HomeViewFactory {
    @MainActor
    public static func makeHomeView(onProductTap: @escaping (String) -> Void) -> some View {
        HomeView(
            viewModel: HomeAssembler.resolveHomeViewModel(),
            onProductTap: onProductTap
        )
    }

    @MainActor
    public static func makeShoppingAssistantView() -> some View {
        ShoppingAssistantView(
            viewModel: HomeAssembler.resolveShoppingAssistantViewModel()
        )
    }
}
