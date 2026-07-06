import SwiftUI
import Common

struct OfferProductCardsSection: View {
    let products: [HomeProduct]
    let favoriteProductIDs: Set<String>
    let onFavoriteTap: (HomeProduct) -> Void
    var onProductTap: ((HomeProduct) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(products) { product in
                    OfferProductCard(product: product,isWishlisted: favoriteProductIDs.contains(product.id),
                                     onFavoriteTap: {
                                         onFavoriteTap(product)
                                     })
                        .padding(.vertical, 8)
                        .onTapGesture { onProductTap?(product) }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ScrollView {
        OfferProductCardsSection(products: MockShopifyData.featuredProducts.map {
            HomeProduct(
                id: $0.id,
                title: $0.title,
                handle: $0.handle,
                featuredImageURL: $0.featuredImageURL,
                price: $0.price,
                currencyCode: $0.currencyCode,
                compareAtPrice: $0.compareAtPrice,
                compareAtCurrencyCode: $0.compareAtCurrencyCode
            )
        },
       favoriteProductIDs: [],
       onFavoriteTap: { _ in }
        )
    }
    .background(Color.appBackgroundGray)
}
