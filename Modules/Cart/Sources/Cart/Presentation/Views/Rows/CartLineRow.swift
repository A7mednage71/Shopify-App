import Common
import SwiftUI

struct CartLineRow: View {
    let line: CartLine
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    let onProductTap: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            Button(action: onProductTap) {
                CartRemoteImage(
                    urlString: line.variant?.image?.url,
                    altText: line.variant?.image?.altText ?? line.productTitle
                )
                .frame(width: 78, height: 78)
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
            }
            .buttonStyle(CartProductImageButtonStyle())

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
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
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

private struct CartProductImageButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .stroke(AppColors.primary.opacity(configuration.isPressed ? 0.42 : 0), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .shadow(
                color: AppColors.primary.opacity(configuration.isPressed ? 0.18 : 0),
                radius: configuration.isPressed ? 10 : 0,
                x: 0,
                y: configuration.isPressed ? 6 : 0
            )
            .animation(.spring(response: 0.24, dampingFraction: 0.76), value: configuration.isPressed)
    }
}
