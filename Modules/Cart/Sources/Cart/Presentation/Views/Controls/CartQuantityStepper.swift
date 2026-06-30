import Common
import SwiftUI

struct CartQuantityStepper: View {
    let quantity: Int
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(spacing: 13) {
            CartQuantityButton(systemName: "minus", action: onDecrement)
                .disabled(quantity <= 1)
                .opacity(quantity <= 1 ? 0.42 : 1)

            Text("\(quantity)")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
                .monospacedDigit()
                .frame(width: 22)

            CartQuantityButton(systemName: "plus", action: onIncrement)
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 7)
        .background(AppColors.backgroundSecondary)
        .clipShape(Capsule())
        .accessibilityElement(children: .contain)
    }
}
