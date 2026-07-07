import SwiftUI
import Common

// MARK: - Reusable Product Card

struct ProductCard: View {
    let product: ShopifyProduct
    var fixedWidth: CGFloat? = 160
    @State private var isWishlisted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

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
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipped()
                .cornerRadius(12)

                // Wishlist
                Button(action: { isWishlisted.toggle() }) {
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
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Description
                Text(product.description)
                    .font(.productDesc)
                    .foregroundColor(.appTextTertiary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(alignment: .center, spacing: 4) {
                    Text(product.formattedPrice)
                        .font(.productPrice)
                        .foregroundColor(.appTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    if let oldPrice = product.formattedComparePrice {
                        Text(oldPrice)
                            .font(.productOldPrice)
                            .foregroundColor(.appTextStrikePrice)
                            .strikethrough(true, color: .appTextStrikePrice)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }

                    if let discount = product.discountPercent {
                        Text("\(discount)% off")
                            .font(.productDiscount)
                            .foregroundColor(.appPrimaryOrange)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }

                    Spacer(minLength: 0)
                }

                HStack(spacing: 3) {
                    StarRatingView(rating: product.rating ?? 0.0, size: 11)
                    Text(formatCount(product.reviewCount ?? 0))
                        .font(.reviewCount)
                        .foregroundColor(.appTextTertiary)
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 8)
            .padding(.bottom, 10)
        }
        .background(Color.appBackgroundWhite)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.appPrimaryOrange.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color.appCardShadow.opacity(0.08), radius: 6, x: 0, y: 2)
        .if(fixedWidth != nil) { $0.frame(width: fixedWidth) }
    }

    private func formatCount(_ n: Int) -> String {
        n >= 1000 ? String(format: "%.0fk", Double(n) / 1000) : "\(n)"
    }
}

// MARK: - View.if helper
private extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition { transform(self) } else { self }
    }
}
