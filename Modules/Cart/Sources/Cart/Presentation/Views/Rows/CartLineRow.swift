import Common
import SwiftUI

struct CartLineRow: View {
    let line: CartLine
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            CartRemoteImage(
                urlString: line.variant?.image?.url,
                altText: line.variant?.image?.altText ?? line.productTitle
            )
            .frame(width: 78, height: 78)
            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))

            VStack(alignment: .leading, spacing: 7) {
                Text(line.productTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                if let optionText = line.optionText {
                    Text(optionText)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(1)
                }

                HStack(alignment: .center, spacing: 12) {
                    CartQuantityStepper(
                        quantity: line.quantity,
                        onIncrement: onIncrement,
                        onDecrement: onDecrement
                    )

                    Spacer(minLength: 8)

                    CartPriceView(money: line.displayMoney)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .layoutPriority(1)
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
        .animation(.easeInOut(duration: 0.18), value: line.quantity)
    }
}
