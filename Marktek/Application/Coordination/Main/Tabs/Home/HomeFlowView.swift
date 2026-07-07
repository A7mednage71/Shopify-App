import SwiftUI
import Home

struct HomeFlowView: View {
    let onProductDetailsTap: (String) -> Void
    let onAssistantTap: () -> Void
    let performProtectedAction: (@escaping () -> Void) -> Void

    var body: some View {
        HomeViewFactory.makeHomeView(
            onProductTap: onProductDetailsTap,
            onAssistantTap: onAssistantTap,
            performProtectedAction: performProtectedAction
        )
    }

    @MainActor
    static func makeShoppingAssistantView(onProductTap: @escaping (String) -> Void) -> some View {
        HomeViewFactory.makeShoppingAssistantView(onProductTap: onProductTap)
    }
}
