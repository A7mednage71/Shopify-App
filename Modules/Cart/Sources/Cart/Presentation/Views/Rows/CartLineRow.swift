import Common
import SwiftUI

struct CartLineRow: View {
    let line: CartLine
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            CartRemoteImage(
                urlString: line.variant?.image?.url,
                altText: line.variant?.image?.altText ?? line.productTitle
            )
            .frame(width: 92, height: 92)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(line.productTitle)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.78)

                    if let optionText = line.optionText {
                        Text(optionText)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(AppColors.textSecondary)
                            .lineLimit(1)
                    }
                }

                CartQuantityStepper(
                    quantity: line.quantity,
                    onIncrement: onIncrement,
                    onDecrement: onDecrement
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            CartPriceView(money: line.displayMoney)
                .frame(width: 92, alignment: .trailing)
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 20)
        .contentShape(Rectangle())
        .animation(.easeInOut(duration: 0.18), value: line.quantity)
    }
}
