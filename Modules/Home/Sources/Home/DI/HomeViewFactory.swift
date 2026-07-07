import SwiftUI

public enum HomeViewFactory {
    @MainActor
    public static func makeHomeView(
        onProductTap: @escaping (String) -> Void,
        performProtectedAction: @escaping (@escaping () -> Void) -> Void = { action in action() }
    ) -> some View {
        HomeView(
            viewModel: HomeAssembler.resolveHomeViewModel(),
            onProductTap: onProductTap,
            performProtectedAction: performProtectedAction
        )
    }

    @MainActor
    public static func makeShoppingAssistantView(onProductTap: @escaping (String) -> Void) -> some View {
        ShoppingAssistantView(
            viewModel: HomeAssembler.resolveShoppingAssistantViewModel(),
            onProductTap: onProductTap
        )
    }
}
