import SwiftUI
import Home

struct HomeFlowView: View {
    let onProductDetailsTap: (String) -> Void
    let performProtectedAction: (@escaping () -> Void) -> Void

    var body: some View {
        HomeViewFactory.makeHomeView(
            onProductTap: onProductDetailsTap,
            performProtectedAction: performProtectedAction
        )
    }
}
