import SwiftUI
import Favorites

struct FavoritesFlowView: View {
    let onProductDetailsTap: (String) -> Void

        var body: some View {
            FavoritesViewFactory.makeFavoritesView(onProductTap: onProductDetailsTap)
        }
}
