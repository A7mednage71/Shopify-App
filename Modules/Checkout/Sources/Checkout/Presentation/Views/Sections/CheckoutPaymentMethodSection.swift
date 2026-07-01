import Common
import SwiftUI

struct CheckoutPaymentMethodSection: View {
    let methods: [CheckoutPaymentMethod]
    let selectedType: CheckoutPaymentMethodType
    let onSelect: (CheckoutPaymentMethodType) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CheckoutSectionHeader(title: CheckoutText.paymentMethodTitle)

            VStack(spacing: 10) {
                ForEach(methods) { method in
                    CheckoutPaymentMethodRow(
                        method: method,
                        isSelected: method.type == selectedType,
                        onSelect: { onSelect(method.type) }
                    )
                }
            }
        }
    }
}

private struct CheckoutPaymentMethodRow: View {
    let method: CheckoutPaymentMethod
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(iconBackgroundColor)
                        .frame(width: 48, height: 48)

                    Image(systemName: method.systemImageName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(iconColor)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(method.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)

                    Text(method.subtitle)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 8)

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

    private var iconBackgroundColor: Color {
        isSelected ? AppColors.primary.opacity(0.14) : AppColors.backgroundSecondary
    }

    private var iconColor: Color {
        switch method.type {
        case .card:
            return AppColors.primary
        case .applePay:
            return AppColors.textPrimary
        case .cashOnDelivery:
            return AppColors.success
        }
    }
}
