import SwiftUI
import Common

struct OfferProductCard: View {
    
    let product: HomeProduct
    let isWishlisted: Bool
    let onFavoriteTap: () -> Void

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack(alignment: .topTrailing) {
                
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
                                .overlay(
                                    ProgressView()
                                        .tint(.appPrimaryOrange)
                                )
                        case .failure(_):
                            Image("product_placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 170, height: 180)
                    .clipped()
                    .cornerRadius(12)
                } else {
                    Image("product_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 170, height: 180)
                        .clipped()
                        .cornerRadius(12)
                }

                // Wishlist
                Button(action: onFavoriteTap) {
                    Image(systemName: isWishlisted ? "heart.fill" : "heart")
                        .foregroundColor(isWishlisted ? .appPrimaryOrange : .appTextSecondary)
                        .font(.system(size: 14))
                        .padding(7)
                        .background(Color.appBackgroundWhite.opacity(0.92))
                        .clipShape(Circle())
                }
                .padding(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                // Name
                Text(product.title)
                    .font(.productName)
                    .foregroundColor(.appTextPrimary)
                    .lineLimit(2)
                    .frame(width: 150, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 3) {
                    StarRatingView(rating: product.rating ?? 0.0, size: 10)
                    Text("(\(formatCount(product.reviewCount ?? 0)))")
                        .font(.reviewCount)
                        .foregroundColor(.appTextTertiary)
                }

                Spacer(minLength: 4)

                // Price
                HStack(alignment: .center, spacing: 4) {
                    Text(product.price)
                        .font(.productPrice)
                        .foregroundColor(.appTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    if let compareAtPrice = product.compareAtPrice {
                        Text(compareAtPrice)
                            .font(.productOldPrice)
                            .foregroundColor(.appTextStrikePrice)
                            .strikethrough(true, color: .appTextStrikePrice)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }

                    Spacer(minLength: 0)
                }
                .frame(width: 150)
            }
            .padding(.horizontal, 8)
            .padding(.top, 6)
            .padding(.bottom, 8)
        }
        .frame(width: 170, height: 260)
        .background(Color.appBackgroundWhite)
        .cornerRadius(14)
        .shadow(color: Color.appCardShadow.opacity(0.08), radius: 6, x: 0, y: 2)
    }

    private func formatCount(_ n: Int) -> String {
        n >= 1000 ? String(format: "%.0fk", Double(n) / 1000) : "\(n)"
    }
}
