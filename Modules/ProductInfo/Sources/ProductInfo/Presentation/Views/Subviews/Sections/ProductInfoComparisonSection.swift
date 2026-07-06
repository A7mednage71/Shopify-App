import SwiftUI

struct ProductInfoComparisonSection: View {
    let onCompareTap: () -> Void

    var body: some View {
        Button(action: onCompareTap) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(ProductPalette.textWhite.opacity(0.2))
                        .frame(width: 44, height: 44)

                    Image(systemName: "sparkles")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(ProductPalette.textWhite)
                }

                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Text(ProductInfoText.compareProductsTitle)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(ProductPalette.textWhite)
                            .lineLimit(1)
                            .minimumScaleFactor(0.82)

                        Text("AI")
                            .font(.system(size: 10, weight: .black, design: .rounded))
                            .foregroundColor(ProductPalette.primary)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(ProductPalette.textWhite)
                            .clipShape(Capsule())
                    }

                    Text(ProductInfoText.compareProductsSubtitle)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(ProductPalette.textWhite.opacity(0.86))
                        .lineLimit(2)
                        .minimumScaleFactor(0.86)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "arrow.left.arrow.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(ProductPalette.textWhite.opacity(0.95))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 15)
            .background(
                LinearGradient(
                    colors: [
                        ProductPalette.primary,
                        ProductPalette.warning
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(ProductPalette.textWhite.opacity(0.18), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: ProductPalette.primary.opacity(0.22), radius: 14, x: 0, y: 8)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(ProductInfoText.compareProductsTitle)
    }
}
