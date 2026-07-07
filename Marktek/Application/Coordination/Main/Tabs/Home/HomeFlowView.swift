import SwiftUI
import Home

struct HomeFlowView: View {
    let onProductDetailsTap: (String) -> Void

    var body: some View {
        HomeViewFactory.makeHomeView(onProductTap: onProductDetailsTap)
    }

    @MainActor
    static func makeShoppingAssistantView(onProductTap: @escaping (String) -> Void) -> some View {
        HomeViewFactory.makeShoppingAssistantView(onProductTap: onProductTap)
    }
}
