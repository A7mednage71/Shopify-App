import SwiftUI

struct ProductsGridSection: View {
    let products: [ShopProduct]
    var onProductTap: ((String) -> Void)? = nil
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(products) { product in
                ShopProductCard(product: product)
                    .onTapGesture {
                        onProductTap?(product.id)
                    }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
    }
}
