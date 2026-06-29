import SwiftUI

struct ProductInfoPurchaseBar: View {
    let productTitle: String
    let displayMoney: ProductMoney
    let quantity: Int
    let isSelectedVariantAvailable: Bool
    let onAddToCart: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 3) {
                Text("Total")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textTertiary)
                    .lineLimit(1)

                Text(displayMoney.formatted(quantity: quantity))
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.58)
            }
            .frame(width: 108, alignment: .leading)

            Button(action: onAddToCart) {
                Label("Add to Cart", systemImage: "bag")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .foregroundColor(.white)
                    .background(isSelectedVariantAvailable ? ProductPalette.primary : ProductPalette.disabled)
                    .clipShape(Capsule())
            }
            .disabled(!isSelectedVariantAvailable)
            .buttonStyle(.plain)
            .accessibilityLabel("Add \(productTitle) to cart")
            .layoutPriority(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
        .padding(.top, 14)
        .padding(.bottom, 16)
        .background(ProductPalette.cardBackground)
        .shadow(color: ProductPalette.shadow, radius: 18, x: 0, y: -8)
    }
}
