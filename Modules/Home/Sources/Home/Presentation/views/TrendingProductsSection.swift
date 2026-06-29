import SwiftUI

// MARK: - Trending Products Section
// Shopify API: products(first: 10, sortKey: BEST_SELLING)
// OR: collection(handle: "trending") { products(first:10) }

struct TrendingProductsSection: View {
    let products: [ShopifyProduct]
    var onViewAll: (() -> Void)? = nil
    var onProductTap: ((ShopifyProduct) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Section Header — Orange bar
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.textWhite)
                    
                    Text("Trending Products")
                        .font(.sectionTitle)
                        .foregroundColor(.textWhite)
                }
                
                Spacer()
                
                Button(action: { onViewAll?() }) {
                    HStack(spacing: 4) {
                        Text("View all")
                            .font(.buttonSmall)
                            .foregroundColor(.textWhite)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 11))
                            .foregroundColor(.textWhite)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.textWhite, lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.primaryOrange)
            
            // Last Date Label
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.system(size: 11))
                    .foregroundColor(.textTertiary)
                Text("Last Date 29/02/22")
                    .font(.system(size: 11))
                    .foregroundColor(.textTertiary)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color.primaryOrange.opacity(0.08))
            
            // Horizontal Product Grid (3 per row, scrollable)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(products) { product in
                        TrendingProductCard(product: product)
                            .onTapGesture {
                                onProductTap?(product)
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
    }
}

// MARK: - Trending Product Card (compact square)
struct TrendingProductCard: View {
    let product: ShopifyProduct
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            // Image
            AsyncImage(url: URL(string: product.featuredImageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.backgroundGray)
            }
            .frame(width: 120, height: 120)
            .clipped()
            .cornerRadius(10)
            
            // Product Name
            Text(product.title)
                .font(.productName)
                .foregroundColor(.textPrimary)
                .lineLimit(1)
                .frame(width: 120, alignment: .leading)
            
            // Price
            Text(product.formattedPrice)
                .font(.productPrice)
                .foregroundColor(.textPrimary)
        }
        .frame(width: 120)
    }
}

// MARK: - Preview
#Preview {
    TrendingProductsSection(products: MockShopifyData.trendingProducts)
}
