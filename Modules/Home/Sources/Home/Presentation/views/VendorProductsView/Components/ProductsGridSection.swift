import SwiftUI

struct ProductsGridSection: View {
    let products: [ShopProduct]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(products) { product in
                ShopProductCard(product: product)
                    .onTapGesture {
                        print("Tapped product: \(product.title)")
                    }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
    }
}
