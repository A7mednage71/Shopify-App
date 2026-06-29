import SwiftUI
import Common

// MARK: - Horizontal Product Cards Section
// Shopify API: products query with collection handle
// GraphQL: collection(handle: "featured") { products(first: 10) { nodes { ... } } }

struct ProductCardsSection: View {
    let products: [ShopifyProduct]
    var onProductTap: ((ShopifyProduct) -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(products) { product in
                    ProductCard(product: product)
                        .onTapGesture {
                            onProductTap?(product)
                        }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Single Product Card
struct ProductCard: View {
    let product: ShopifyProduct
    @State private var isWishlisted = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            // Product Image
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.featuredImageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.appBackgroundGray)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.appTextTertiary)
                        )
                }
                .frame(width: 160, height: 180)
                .clipped()
                .cornerRadius(12)
                
                // Wishlist Button
                Button(action: { isWishlisted.toggle() }) {
                    Image(systemName: isWishlisted ? "heart.fill" : "heart")
                        .foregroundColor(isWishlisted ? .appPrimaryOrange : .appTextSecondary)
                        .font(.system(size: 16))
                        .padding(8)
                        .background(Color.appBackgroundWhite.opacity(0.9))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            // Product Name
            Text(product.title)
                .productNameStyle()
                .lineLimit(2)
                .frame(width: 160, alignment: .leading)
            
            // Description
            Text(product.description)
                .font(.productDesc)
                .foregroundColor(.appTextTertiary)
                .lineLimit(2)
                .frame(width: 160, alignment: .leading)
            
            // Price Row
            HStack(alignment: .bottom, spacing: 6) {
                Text(product.formattedPrice)
                    .productPriceStyle()
                    .foregroundColor(.appTextPrimary)
                
                if let oldPrice = product.formattedComparePrice {
                    Text(oldPrice)
                        .font(.productOldPrice)
                        .foregroundColor(.appTextStrikePrice)
                        .strikethrough(true, color: .appTextStrikePrice)
                }
                
                if let discount = product.discountPercent {
                    Text(HomeStrings.ProductCard.discountLabel(discount))
                        .font(.productDiscount)
                        .foregroundColor(.appPrimaryOrange)
                }
            }
            
            // Star Rating
            if let rating = product.rating {
                HStack(spacing: 4) {
                    StarRatingView(rating: rating, size: 12)
                    
                    if let count = product.reviewCount {
                        Text(formatCount(count))
                            .font(.reviewCount)
                            .foregroundColor(.appTextTertiary)
                    }
                }
            }
        }
        .frame(width: 160)
        .padding(10)
        .background(Color.appBackgroundWhite)
        .cornerRadius(14)
        .shadow(color: Color.appCardShadow, radius: 8, x: 0, y: 2)
    }
    
    private func formatCount(_ count: Int) -> String {
        if count >= 1000 {
            return String(format: "%.0fk", Double(count) / 1000)
        }
        return "\(count)"
    }
}

// MARK: - Star Rating View
struct StarRatingView: View {
    let rating: Double
    let size: CGFloat
    let maxStars: Int = 5
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxStars, id: \.self) { star in
                starImage(for: star)
                    .font(.system(size: size))
            }
        }
    }
    
    @ViewBuilder
    private func starImage(for star: Int) -> some View {
        let filled = Double(star) <= rating
        let halfFilled = !filled && Double(star) - 0.5 <= rating
        
        if filled {
            Image(systemName: "star.fill").foregroundColor(.appStarFilled)
        } else if halfFilled {
            Image(systemName: "star.leadinghalf.filled").foregroundColor(.appStarFilled)
        } else {
            Image(systemName: "star").foregroundColor(.appStarEmpty)
        }
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        ProductCardsSection(products: MockShopifyData.featuredProducts)
    }
}
