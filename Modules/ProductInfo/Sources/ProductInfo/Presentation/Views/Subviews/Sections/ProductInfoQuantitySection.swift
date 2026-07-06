import SwiftUI

struct ProductInfoQuantitySection: View {
    let quantity: Int
    let maxSelectableQuantity: Int
    let isSelectedVariantAvailable: Bool
    let onDecrement: () -> Void
    let onIncrement: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Text(ProductInfoText.quantityTitle)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)

            Spacer()

            HStack(spacing: 16) {
                QuantityButton(systemName: "minus", action: onDecrement)
                    .disabled(quantity <= 1)

                Text("\(quantity)")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textPrimary)
                    .frame(width: 22)

                QuantityButton(systemName: "plus", action: onIncrement)
                    .disabled(!isSelectedVariantAvailable || quantity >= maxSelectableQuantity)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(ProductPalette.controlBackground)
            .clipShape(Capsule())
        }
    }
}
