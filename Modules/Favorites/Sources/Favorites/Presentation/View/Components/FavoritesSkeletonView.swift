import SwiftUI
import Common
import Shimmer

struct FavoritesSkeletonView: View {
    private let mockProducts = [
        FavoriteProduct(id: "1", title: "Product Placeholder Title One", imageURL: "", price: 99.99, currencyCode: "USD", compareAtPrice: 120.00),
        FavoriteProduct(id: "2", title: "Product Placeholder Title Two", imageURL: "", price: 49.99, currencyCode: "USD", compareAtPrice: nil),
        FavoriteProduct(id: "3", title: "Product Placeholder Title Three", imageURL: "", price: 29.99, currencyCode: "USD", compareAtPrice: nil),
        FavoriteProduct(id: "4", title: "Product Placeholder Title Four", imageURL: "", price: 199.99, currencyCode: "USD", compareAtPrice: 250.00)
    ]
    
    var body: some View {
        FavoritesGridSection(
            products: mockProducts,
            onProductTap: { _ in },
            onRemove: { _ in }
        )
        .redacted(reason: .placeholder)
        .shimmering()
        .disabled(true)
    }
}
