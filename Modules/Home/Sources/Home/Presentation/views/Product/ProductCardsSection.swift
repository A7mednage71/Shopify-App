import SwiftUI
import Common

struct ProductCardsSection: View {
    let products: [SearchProduct]
    var onProductTap: ((SearchProduct) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(products) { product in
                    ProductCard(product: product)
                        .padding(.vertical, 8)
                        .onTapGesture { onProductTap?(product) }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ScrollView { ProductCardsSection(products: MockShopifyData.featuredProducts) }
    .background(Color.appBackgroundGray)
}
