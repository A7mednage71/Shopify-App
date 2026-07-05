import Common
import SwiftUI

struct CheckoutShippingMethodSection: View {
    let methods: [CheckoutShippingMethod]
    let selectedMethod: CheckoutShippingMethod
    let currencyCode: String
    let onSelect: (CheckoutShippingMethod) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CheckoutSectionHeader(title: CheckoutText.shippingMethodTitle)

            VStack(spacing: 10) {
                ForEach(methods) { method in
                    CheckoutShippingMethodRow(
                        method: method,
                        isSelected: method == selectedMethod,
                        currencyCode: currencyCode,
                        onSelect: { onSelect(method) }
                    )
                }
            }
        }
    }
}

private struct CheckoutShippingMethodRow: View {
    let method: CheckoutShippingMethod
    let isSelected: Bool
    let currencyCode: String
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(isSelected ? AppColors.primary.opacity(0.14) : AppColors.backgroundSecondary)
                        .frame(width: 48, height: 48)

                    Image(systemName: method == .express ? "bolt.fill" : "shippingbox.fill")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(isSelected ? AppColors.primary : AppColors.textSecondary)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(method.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)

                    Text(method.deliveryEstimate)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)
                }

                Spacer(minLength: 8)

                Text(method.amount.checkoutFormattedCurrency(currencyCode: currencyCode))
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .monospacedDigit()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "chevron.right")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isSelected ? AppColors.primary : AppColors.textTertiary)
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .background(AppColors.background)
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(isSelected ? AppColors.primary : AppColors.border, lineWidth: isSelected ? 1.4 : 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
