import SwiftUI
import Common

// MARK: - Trending Products Section
// Shopify API: products(first: 10, sortKey: BEST_SELLING)
// OR: collection(handle: "trending") { products(first:10) }

struct TrendingProductsSection: View {
    let products: [ShopifyProduct]
    var onViewAll: (() -> Void)? = nil
    var onProductTap: ((ShopifyProduct) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Section Header — Unified orange banner card
            HStack(alignment: .center) {
                // Left: Title + Date
                VStack(alignment: .leading, spacing: 4) {
                    Text(HomeStrings.Trending.sectionTitle)
                        .font(.sectionTitle)
                        .foregroundColor(.appTextWhite)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundColor(.appTextWhite.opacity(0.85))
                        Text(HomeStrings.Trending.lastDate)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.appTextWhite.opacity(0.85))
                    }
                }
                
                Spacer()
                
                // Right: View All button
                Button(action: { onViewAll?() }) {
                    HStack(spacing: 5) {
                        Text(HomeStrings.Trending.viewAll)
                            .font(.buttonSmall)
                            .foregroundColor(.appTextWhite)
                        Text("→")
                            .font(.sectionAction)
                            .foregroundColor(.appTextWhite)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.appTextWhite, lineWidth: 1.5)
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.appPrimaryOrange)
            .cornerRadius(14)
            .padding(.horizontal, 16)
            
            // Horizontal Product Grid
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
        VStack(alignment: .leading, spacing: 0) {
            
            // Image — full width, no side padding
            AsyncImage(url: URL(string: product.featuredImageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.appBackgroundGray)
            }
            .frame(width: 140, height: 130)
            .clipped()
            
            // Text block
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.productName)
                    .foregroundColor(.appTextPrimary)
                    .lineLimit(1)
                
                Text(product.formattedPrice)
                    .font(.productPrice)
                    .foregroundColor(.appPrimaryOrange)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
        }
        .frame(width: 140)
        .background(Color.appBackgroundWhite)
        .cornerRadius(12)
        .shadow(color: Color.appCardShadow, radius: 6, x: 0, y: 2)
    }
}


