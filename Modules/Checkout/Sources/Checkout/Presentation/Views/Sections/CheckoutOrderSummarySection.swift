import Common
import SwiftUI

struct CheckoutOrderSummarySection: View {
    let cart: CartDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(CheckoutText.orderSummaryTitle)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            VStack(spacing: 10) {
                CheckoutSummaryRow(title: CheckoutText.discountCodeTitle, value: discountCodeText)
                CheckoutSummaryRow(title: CheckoutText.subtotalTitle, value: cart.cost.subtotalAmount.checkoutFormattedCurrency())
                CheckoutSummaryRow(title: CheckoutText.discountTitle, value: discountText)

                Divider()
                    .background(AppColors.border)
                    .padding(.top, 6)

                CheckoutSummaryRow(
                    title: CheckoutText.totalTitle,
                    value: cart.cost.totalAmount.checkoutFormattedCurrency(),
                    isTotal: true
                )
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var discountCodeText: String {
        cart.discountCodes.first(where: \.applicable)?.code ?? CheckoutText.noDiscountCode
    }

    private var discountText: String {
        let discount = cart.cost.subtotalAmount.checkoutSubtracting(cart.cost.totalAmount, clampedToZero: true)

        guard discount.checkoutDecimalValue > 0 else {
            return discount.checkoutFormattedCurrency()
        }

        return "-\(discount.checkoutFormattedCurrency())"
    }
}

private struct CheckoutSummaryRow: View {
    let title: String
    let value: String
    var isTotal = false

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.system(size: isTotal ? 17 : 16, weight: isTotal ? .bold : .semibold))
                .foregroundColor(isTotal ? AppColors.textPrimary : AppColors.textSecondary)

            Spacer(minLength: 12)

            Text(value)
                .font(.system(size: isTotal ? 17 : 16, weight: .bold))
                .foregroundColor(isTotal ? AppColors.textPrimary : AppColors.textSecondary)
                .multilineTextAlignment(.trailing)
                .monospacedDigit()
        }
    }
}
