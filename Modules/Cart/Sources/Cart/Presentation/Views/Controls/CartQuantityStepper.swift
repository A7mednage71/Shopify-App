import Common
import SwiftUI

struct CartQuantityStepper: View {
    let quantity: Int
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(spacing: 9) {
            CartQuantityButton(systemName: "minus", action: onDecrement)
                .disabled(quantity <= 1)
                .opacity(quantity <= 1 ? 0.42 : 1)

            Text("\(quantity)")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.82)
                .frame(minWidth: 20)

            CartQuantityButton(systemName: "plus", action: onIncrement)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 6)
        .background(AppColors.backgroundSecondary)
        .clipShape(Capsule())
        .accessibilityElement(children: .contain)
    }
}
