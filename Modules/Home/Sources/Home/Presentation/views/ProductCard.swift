import SwiftUI
import Common


struct ProductCard: View {
    
    let product: Product
    @State private var isWishlisted = false

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack(alignment: .topTrailing) {
                
                if let imageURL = product.featuredImageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
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
                    .frame(width: 170, height: 180)
                    .clipped()
                    .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Color.appBackgroundGray)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.appTextTertiary)
                        )
                        .frame(width: 170, height: 180)
                        .cornerRadius(12)
                }

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

            VStack(alignment: .leading, spacing: 2) {
                // Name
                Text(product.title)
                    .font(.productName)
                    .foregroundColor(.appTextPrimary)
                    .lineLimit(2)
                    .frame(width: 150, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)

                // Description
                Text(product.description)
                    .font(.productDesc)
                    .foregroundColor(.appTextTertiary)
                    .lineLimit(2)
                    .frame(width: 150, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 2)

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
        .frame(width: 170, height: 290)
        .background(Color.appBackgroundWhite)
        .cornerRadius(14)
        .shadow(color: Color.appCardShadow.opacity(0.08), radius: 6, x: 0, y: 2)
    }
}
