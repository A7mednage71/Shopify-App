import SwiftUI

struct ProductInfoCartToolbarButton: View {
    let onCartTap: () -> Void
    let cartQuantity: Int?
    let cartBadgeScale: CGFloat
    let onFrameChange: (CGRect) -> Void

    var body: some View {
        Button(action: onCartTap, label: cartButtonLabel)
        .buttonStyle(.plain)
        .accessibilityLabel(ProductInfoText.viewCartAccessibilityLabel)
    }

    private func cartButtonLabel() -> some View {
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
}

struct ProductInfoFavoriteToolbarButton: View {
        let isFavorite: Bool
        let action: () -> Void

        var body: some View {
            Button(action: action) { 
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
