import Common
import SwiftUI

struct CartOrderSummaryView: View {
    let cart: CartDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(CartText.orderSummaryTitle)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            VStack(spacing: 10) {
                CartSummaryRow(title: CartText.itemsSummaryTitle, value: "\(cart.totalQuantity)")
                CartSummaryRow(title: CartText.subtotalSummaryTitle, value: cart.cost.subtotalAmount.formattedCurrency(fractionDigits: 0))
                CartSummaryRow(title: CartText.discountSummaryTitle, value: discountText)

                Divider()
                    .background(AppColors.border)
                    .padding(.top, 6)

                CartSummaryRow(
                    title: CartText.totalSummaryTitle,
                    value: cart.cost.totalAmount.formattedCurrency(fractionDigits: 0),
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

    private var discountText: String {
        let discount = cart.cost.subtotalAmount.subtracting(cart.cost.totalAmount, clampedToZero: true)

        guard discount.decimalValue > 0 else {
            return discount.formattedCurrency(fractionDigits: 0)
        }

        return "-\(discount.formattedCurrency(fractionDigits: 0))"
    }
}
