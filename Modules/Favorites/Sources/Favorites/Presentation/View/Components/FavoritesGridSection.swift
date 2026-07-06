import SwiftUI
import Common

struct FavoritesGridSection: View {
    let products: [FavoriteProduct]
    let onProductTap: (String) -> Void
    let onRemove: (FavoriteProduct) -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(products) { product in
                FavoriteProductCard(product: product) {
                    onRemove(product)
                }
                .onTapGesture {
                    onProductTap(product.id)
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }
}
