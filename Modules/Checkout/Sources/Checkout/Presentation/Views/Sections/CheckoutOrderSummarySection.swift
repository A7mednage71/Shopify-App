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
                CheckoutSummaryRow(title: CheckoutText.subtotalTitle, value: subtotalText)
                CheckoutSummaryRow(title: CheckoutText.shippingTitle, value: shippingText)
                CheckoutSummaryRow(title: CheckoutText.discountTitle, value: discountText)

                if let warningText {
                    CheckoutDiscountWarningView(message: warningText)
                }

                Divider()
                    .background(AppColors.border)
                    .padding(.top, 6)

                CheckoutSummaryRow(
                    title: CheckoutText.totalTitle,
                    value: totalText,
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

    private var subtotalText: String {
        guard let pricing else {
            return cart.cost.subtotalAmount.checkoutFormattedCurrency()
        }

        return pricing.subtotal.checkoutFormattedCurrency(currencyCode: pricing.currencyCode)
    }

    private var shippingText: String {
        selectedShippingMethod.amount.checkoutFormattedCurrency(currencyCode: currencyCode)
    }

    private var discountText: String {
        guard let pricing, pricing.discountAmount > 0 else {
            return Decimal(0).checkoutFormattedCurrency(currencyCode: currencyCode)
        }

        return "-\(pricing.discountAmount.checkoutFormattedCurrency(currencyCode: pricing.currencyCode))"
    }

    private var totalText: String {
        guard let pricing else {
            let subtotal = cart.cost.subtotalAmount.checkoutDecimalValue
            let total = subtotal + selectedShippingMethod.amount
            return total.checkoutFormattedCurrency(currencyCode: currencyCode)
        }

        return pricing.total.checkoutFormattedCurrency(currencyCode: pricing.currencyCode)
    }

    private var warningText: String? {
        guard case .notApplicable(_, let message) = pricing?.discountState else {
            return nil
        }

        return message
    }

    private var currencyCode: String {
        if let pricing {
            return pricing.currencyCode
        }

        return cart.cost.totalAmount.currencyCode.isEmpty
            ? cart.cost.subtotalAmount.currencyCode
            : cart.cost.totalAmount.currencyCode
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
