import Common
import SwiftUI

struct CheckoutOrderSummarySection: View {
    let cart: CartDetails
    let selectedShippingMethod: CheckoutShippingMethod
    let pricing: CheckoutPricing?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(CheckoutText.orderSummaryTitle)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            VStack(spacing: 10) {
                CheckoutSummaryRow(title: CheckoutText.discountCodeTitle, value: discountCodeText)
                CheckoutPriceSummaryRow(title: CheckoutText.subtotalTitle, priceInUSD: subtotalPriceValue)
                CheckoutPriceSummaryRow(title: CheckoutText.shippingTitle, priceInUSD: shippingPriceValue)
                CheckoutPriceSummaryRow(title: CheckoutText.discountTitle, priceInUSD: discountPriceValue)

                if let warningText {
                    CheckoutDiscountWarningView(message: warningText)
                }

                Divider()
                    .background(AppColors.border)
                    .padding(.top, 6)

                CheckoutPriceSummaryRow(
                    title: CheckoutText.totalTitle,
                    priceInUSD: totalPriceValue,
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
        guard let discountState = pricing?.discountState else {
            return cart.discountCodes.first(where: \.applicable)?.code ?? CheckoutText.noDiscountCode
        }

        switch discountState {
        case .applied(let code), .notApplicable(let code, _):
            return code
        case .none:
            return CheckoutText.noDiscountCode
        }
    }

    private var subtotalPriceValue: Double {
        guard let pricing else {
            return cart.cost.subtotalAmount.checkoutPriceViewValue
        }

        return pricing.subtotal.checkoutPriceViewValue
    }

    private var shippingPriceValue: Double {
        selectedShippingMethod.amount.checkoutPriceViewValue
    }

    private var discountPriceValue: Double {
        guard let pricing, pricing.discountAmount > 0 else {
            return 0
        }

        return -pricing.discountAmount.checkoutPriceViewValue
    }

    private var totalPriceValue: Double {
        guard let pricing else {
            let subtotal = cart.cost.subtotalAmount.checkoutDecimalValue
            let total = subtotal + selectedShippingMethod.amount
            return total.checkoutPriceViewValue
        }

        return pricing.total.checkoutPriceViewValue
    }

    private var warningText: String? {
        guard case .notApplicable(_, let message) = pricing?.discountState else {
            return nil
        }

        return message
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

private struct CheckoutPriceSummaryRow: View {
    let title: String
    let priceInUSD: Double
    var isTotal = false

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.system(size: isTotal ? 17 : 16, weight: isTotal ? .bold : .semibold))
                .foregroundColor(isTotal ? AppColors.textPrimary : AppColors.textSecondary)

            Spacer(minLength: 12)

            PriceView(
                priceInUSD: priceInUSD,
                font: .system(size: isTotal ? 17 : 16, weight: .bold),
                color: isTotal ? AppColors.textPrimary : AppColors.textSecondary
            )
            .multilineTextAlignment(.trailing)
            .monospacedDigit()
        }
    }
}

private struct CheckoutDiscountWarningView: View {
    let message: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(AppColors.primary)
                .padding(.top, 1)

            Text(message)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.primary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
