import Common
import SwiftUI

struct CheckoutOrderConfirmationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var hasAppeared = false

    let confirmation: CheckoutOrderConfirmation

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                confirmationHeader

                paymentCard

                CheckoutProductsSection(lines: confirmation.cart.lines)

                CheckoutOrderSummarySection(cart: confirmation.cart)

                CheckoutPrimaryButton(title: CheckoutText.orderConfirmationDoneTitle) {
                    dismiss()
                }
            }
            .padding(.horizontal, 22)
            .padding(.top, 22)
            .padding(.bottom, 28)
            .opacity(hasAppeared ? 1 : 0)
            .offset(y: hasAppeared ? 0 : 20)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle(CheckoutText.orderConfirmationNavigationTitle)
        .checkoutNavigationTitleStyle()
        .onAppear {
            withAnimation(.spring(response: 0.46, dampingFraction: 0.84)) {
                hasAppeared = true
            }
        }
    }

    private var confirmationHeader: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(AppColors.success.opacity(0.14))
                    .frame(width: 92, height: 92)
                    .scaleEffect(hasAppeared ? 1 : 0.78)

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 58, weight: .semibold))
                    .foregroundColor(AppColors.success)
                    .scaleEffect(hasAppeared ? 1 : 0.62)
            }
            .accessibilityHidden(true)
            .animation(.spring(response: 0.5, dampingFraction: 0.72).delay(0.08), value: hasAppeared)

            VStack(spacing: 8) {
                Text(CheckoutText.orderConfirmationTitle)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text(CheckoutText.orderConfirmationMessage)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
    }

    private var paymentCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(CheckoutText.orderConfirmationDetailsTitle)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            VStack(spacing: 12) {
                confirmationRow(
                    title: CheckoutText.paymentMethodTitle,
                    value: confirmation.paymentMethodTitle
                )

                confirmationRow(
                    title: CheckoutText.totalTitle,
                    value: confirmation.cart.cost.totalAmount.checkoutFormattedCurrency(),
                    isEmphasized: true
                )
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private func confirmationRow(
        title: String,
        value: String,
        isEmphasized: Bool = false
    ) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(AppColors.textSecondary)

            Spacer(minLength: 12)

            Text(value)
                .font(.system(size: isEmphasized ? 17 : 16, weight: .bold))
                .foregroundColor(isEmphasized ? AppColors.textPrimary : AppColors.textSecondary)
                .multilineTextAlignment(.trailing)
                .monospacedDigit()
        }
    }
}
