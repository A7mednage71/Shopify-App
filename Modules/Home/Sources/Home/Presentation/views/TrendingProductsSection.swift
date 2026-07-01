import SwiftUI
import Common

// MARK: - Trending Products Section

struct TrendingProductsSection: View {
    let products: [Product]
    var onProductTap: ((Product) -> Void)? = nil
    
    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text(HomeStrings.Trending.sectionTitle)
                    .font(.sectionTitle)
                    .foregroundColor(.appTextWhite)
                
                HStack(spacing: 5) {
                    Image(systemName: "calendar")
                        .font(.system(size: 11))
                    Text(HomeStrings.Trending.lastDate)
                        .font(.system(size: 11, weight: .regular))
                }
                .foregroundColor(.appTextWhite.opacity(0.9))
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(products.enumerated()), id: \.element.id) { index, product in
                        TrendingProductCard(product: product, index: index)
                            .padding(.vertical, 4)
                            .onTapGesture {
                                onProductTap?(product)
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .background(Color.appPrimaryOrange)
        .cornerRadius(14)
        .padding(.horizontal, 16)
    }
}

// MARK: - Trending Product Card (compact square)
struct TrendingProductCard: View {
    let product: Product
    let index: Int

    private let cardWidth: CGFloat = 140
    private let cardHeight: CGFloat = 190

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            // Background image — fills entire card
            Group {
                if let imageURL = product.featuredImageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .empty:
                            Rectangle()
                                .fill(Color.appBackgroundGray)
                                .overlay(ProgressView().tint(.appTextTertiary))
                        default:
                            Rectangle()
                                .fill(Color.appBackgroundGray)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.appTextTertiary)
                                )
                        }
                    }
                } else {
                    Rectangle()
                        .fill(Color.appBackgroundGray)
                }
            }
            .frame(width: cardWidth, height: cardHeight)
            .clipped()

            // Gradient — stronger and taller for legibility
            LinearGradient(
                colors: [
                    .black.opacity(0),
                    .black.opacity(0),
                    .black.opacity(0.55),
                    .black.opacity(0.85)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: cardWidth, height: cardHeight)

            // Product info — overlaid on top of image
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 6) {
                    Text(product.price)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)

                    if let compareAtPrice = product.compareAtPrice {
                        Text(compareAtPrice)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white.opacity(0.65))
                            .strikethrough(true, color: .white.opacity(0.65))
                    }
                }
            }
            .padding(12)

            // Trending rank badge — top leading
            HStack(spacing: 4) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 10, weight: .bold))
                Text("#\(index + 1)")
                    .font(.system(size: 12, weight: .bold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.appPrimaryOrange, Color.appPrimaryOrange.opacity(0.85)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .shadow(color: Color.appPrimaryOrange.opacity(0.4), radius: 4, x: 0, y: 2)
            .padding(8)
            .frame(width: cardWidth, height: cardHeight, alignment: .topLeading)

            // Discount badge — top trailing (only if on sale)
            if let discount = discountPercentage {
                Text("-\(discount)%")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(Color.red))
                    .frame(width: cardWidth, height: cardHeight, alignment: .topTrailing)
                    .padding(8)
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.appBackgroundWhite)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: Color.appCardShadow.opacity(0.25), radius: 10, x: 0, y: 6)
    }

    // Helper to compute discount % if compareAtPrice exists and is valid
    private var discountPercentage: Int? {
        guard let compareAtPrice = product.compareAtPrice,
              let compareValue = Double(compareAtPrice.filter { "0123456789.".contains($0) }),
              let priceValue = Double(product.price.filter { "0123456789.".contains($0) }),
              compareValue > priceValue else {
            return nil
        }
        let discount = ((compareValue - priceValue) / compareValue) * 100
        return Int(discount.rounded())
    }
}
