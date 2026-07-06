import SwiftUI
import Common

struct ProductInfoPurchaseBar: View {
    let productTitle: String
    let displayMoney: ProductMoney
    let quantity: Int
    let isSelectedVariantAvailable: Bool
    let addToCartState: ProductInfoAddToCartState
    let onAddButtonFrameChange: (CGRect) -> Void
    let onAddToCart: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(ProductInfoText.totalTitle)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.textTertiary)
                        .lineLimit(1)

                    let amountAsDouble = Double(displayMoney.amount) ?? 0.0
                    let totalUSD = amountAsDouble * Double(quantity)

                    PriceView(
                        priceInUSD: totalUSD,
                        font: .system(size: 25, weight: .bold, design: .rounded),
                        color: ProductPalette.textPrimary
                    )
                    .lineLimit(1)
                    .minimumScaleFactor(0.58)
                   
              }
               .frame(width: 108, alignment: .leading)

                Button(action: onAddToCart) {
                    ProductInfoAddToCartButtonContent(isAddingToCart: isAddingToCart)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .foregroundColor(ProductPalette.textWhite)
                        .background(buttonBackgroundColor)
                        .clipShape(Capsule())
                }
                .disabled(!isSelectedVariantAvailable || isAddingToCart)
                .buttonStyle(.plain)
                .accessibilityLabel(ProductInfoText.addToCartAccessibilityLabel(productTitle: productTitle))
                .layoutPriority(1)
                .background(
                    ProductInfoFrameReader(onChange: onAddButtonFrameChange)
                )
            }

            if let message = statusMessage {
                Text(message.text)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(message.color)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
        .padding(.top, 14)
        .padding(.bottom, 16)
        .background(ProductPalette.cardBackground)
        .shadow(color: ProductPalette.shadow, radius: 18, x: 0, y: -8)
    }

    private var isAddingToCart: Bool {
        if case .loading = addToCartState {
            return true
        }

        return false
    }

    private var buttonBackgroundColor: Color {
        isSelectedVariantAvailable && !isAddingToCart ? ProductPalette.primary : ProductPalette.disabled
    }

    private var statusMessage: (text: String, color: Color)? {
        switch addToCartState {
        case .idle, .loading:
            return nil

        case .success:
            return nil

        case .failure(let message):
            return (message, ProductPalette.error)
        }
    }
}
