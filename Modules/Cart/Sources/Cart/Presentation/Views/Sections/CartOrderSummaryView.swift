import Common
import SwiftUI

struct CartOrderSummaryView: View {
    let cart: CartDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            Text(CartText.orderSummaryTitle)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            VStack(spacing: 13) {
                CartSummaryRow(title: CartText.itemsSummaryTitle, value: "\(cart.totalQuantity)")
                CartSummaryRow(title: CartText.subtotalSummaryTitle, value: cart.cost.subtotalAmount.formattedCurrency(fractionDigits: 0))

                Divider()
                    .background(AppColors.border)
                    .padding(.top, 10)

                CartSummaryRow(
                    title: CartText.totalSummaryTitle,
                    value: cart.cost.totalAmount.formattedCurrency(fractionDigits: 0),
                    isTotal: true
                )
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
