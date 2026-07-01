import SwiftUI
import Common

struct ProductCardsSection: View {
    let products: [ShopifyProduct]
    var onProductTap: ((ShopifyProduct) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(products) { product in
                    ProductCard(product: product, fixedWidth: 165)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
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
