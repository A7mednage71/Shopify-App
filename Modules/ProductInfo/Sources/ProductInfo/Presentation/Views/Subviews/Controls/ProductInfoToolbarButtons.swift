import SwiftUI

struct ProductInfoCartToolbarButton: View {
    let cartDestination: () -> AnyView
    let cartQuantity: Int?
    let cartBadgeScale: CGFloat
    let onFrameChange: (CGRect) -> Void

    var body: some View {
        NavigationLink(destination: cartDestination()) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(ProductPalette.textPrimary)

                if let cartQuantity, cartQuantity > 0 {
                    Text("\(cartQuantity)")
                        .font(.system(size: 7, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.textWhite)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .monospacedDigit()
                        .frame(minWidth: 11, minHeight: 11)
                        .padding(.horizontal, cartQuantity > 9 ? 2 : 0)
                        .background(ProductPalette.primary)
                        .clipShape(Capsule())
                        .offset(x: 3, y: -2)
                        .scaleEffect(cartBadgeScale)
                }
            }
            .frame(width: 30, height: 30)
            .background(ProductInfoFrameReader(onChange: onFrameChange))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(ProductInfoText.viewCartAccessibilityLabel)
    }
}

struct ProductInfoFavoriteToolbarButton: View {
    @Binding var isFavorite: Bool

    var body: some View {
        Button(action: { isFavorite.toggle() }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isFavorite ? ProductPalette.favorite : ProductPalette.textPrimary)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            isFavorite
                ? ProductInfoText.removeFromFavoritesAccessibilityLabel
                : ProductInfoText.addToFavoritesAccessibilityLabel
        )
    }
}
