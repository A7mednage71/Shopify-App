import Common
import SwiftUI

struct CartFailureView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            Spacer(minLength: 36)

            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(AppColors.primary.opacity(0.12))
                        .frame(width: 84, height: 84)

                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }

                VStack(spacing: 9) {
                    Text(CartText.failureTitle)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .multilineTextAlignment(.center)

                    Text(cleanMessage)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                        .lineSpacing(4)
                        .multilineTextAlignment(.center)
                }

                Button(action: onRetry) {
                    Label(CartText.failureRetryTitle, systemImage: "arrow.clockwise")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColors.textWhite)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(AppColors.primary)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 28)
            .frame(maxWidth: 360)
            .background(AppColors.background)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: AppColors.shadow, radius: 22, x: 0, y: 12)
            .padding(.horizontal, 24)

            Text(CartText.failureHelpMessage)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppColors.textTertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 36)

            Spacer(minLength: 36)
        }
    }

    private var cleanMessage: String {
        let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedMessage.isEmpty ? CartText.failureFallbackMessage : trimmedMessage
    }
}
