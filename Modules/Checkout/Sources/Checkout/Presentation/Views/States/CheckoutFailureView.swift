import Common
import SwiftUI

struct CheckoutFailureView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 42, weight: .bold))
                .foregroundColor(AppColors.error)

            Text("Checkout could not load")
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Button(action: onRetry) {
                Text("Try Again")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(AppColors.textWhite)
                    .padding(.horizontal, 24)
                    .frame(height: 44)
                    .background(AppColors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}
