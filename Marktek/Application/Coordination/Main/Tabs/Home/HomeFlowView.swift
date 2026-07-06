import SwiftUI
import Home

struct HomeFlowView: View {
    let onProductDetailsTap: (String) -> Void

    var body: some View {
        HomeViewFactory.makeHomeView(onProductTap: onProductDetailsTap)
    }
}
