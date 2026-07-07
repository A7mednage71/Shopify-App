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
                CartPriceSummaryRow(title: CartText.subtotalSummaryTitle, money: cart.cost.subtotalAmount)
                CartPriceSummaryRow(title: CartText.discountSummaryTitle, priceInUSD: discountPriceValue)

                Divider()
                    .background(AppColors.border)
                    .padding(.top, 6)

                CartPriceSummaryRow(
                    title: CartText.totalSummaryTitle,
                    money: cart.cost.totalAmount,
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

    private var discountPriceValue: Double {
        let discount = cart.cost.subtotalAmount.subtracting(cart.cost.totalAmount, clampedToZero: true)

        guard discount.decimalValue > 0 else {
            return 0
        }

        return -discount.priceViewValue
    }
}

private struct CartPriceSummaryRow: View {
    let title: String
    let priceInUSD: Double
    var isTotal = false

    init(title: String, money: CartMoney, isTotal: Bool = false) {
        self.title = title
        self.priceInUSD = money.priceViewValue
        self.isTotal = isTotal
    }

    init(title: String, priceInUSD: Double, isTotal: Bool = false) {
        self.title = title
        self.priceInUSD = priceInUSD
        self.isTotal = isTotal
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: isTotal ? 17 : 16, weight: isTotal ? .bold : .semibold))
                .foregroundColor(isTotal ? AppColors.textPrimary : AppColors.textSecondary)

            Spacer()

            PriceView(
                priceInUSD: priceInUSD,
                font: .system(size: isTotal ? 17 : 16, weight: .bold),
                color: isTotal ? AppColors.textPrimary : AppColors.textSecondary
            )
            .monospacedDigit()
        }
    }
}
