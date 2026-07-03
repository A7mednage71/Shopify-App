import SwiftUI
import Shimmer

struct VendorProductsSkeletonView: View {
    var body: some View {
        ProductsGridSection(products: Array(MockShopifyData.featuredProducts.prefix(4)))
            .redacted(reason: .placeholder)
            .shimmering()
            .disabled(true)
    }
}
