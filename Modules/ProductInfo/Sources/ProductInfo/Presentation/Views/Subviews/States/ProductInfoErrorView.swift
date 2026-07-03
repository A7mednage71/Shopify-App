import SwiftUI

struct ProductInfoErrorView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        ZStack {
            ProductPalette.pageBackground
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer(minLength: 36)

                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(ProductPalette.error.opacity(0.1))
                            .frame(width: 84, height: 84)

                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 34, weight: .semibold))
                            .foregroundColor(ProductPalette.error)
                    }

                    VStack(spacing: 9) {
                        Text(ProductInfoText.productLoadFailureTitle)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(ProductPalette.textPrimary)
                            .multilineTextAlignment(.center)

                        Text(cleanMessage)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(ProductPalette.textSecondary)
                            .lineSpacing(4)
                            .multilineTextAlignment(.center)
                    }

                    Button(action: onRetry) {
                        Label(ProductInfoText.retryButtonTitle, systemImage: "arrow.clockwise")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(ProductPalette.textWhite)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(ProductPalette.primary)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(ProductInfoText.retryAccessibilityLabel)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 28)
                .frame(maxWidth: 360)
                .background(ProductPalette.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: ProductPalette.shadow, radius: 22, x: 0, y: 12)
                .padding(.horizontal, 24)

                Text(ProductInfoText.failureHelpMessage)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(ProductPalette.textTertiary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 36)

                Spacer(minLength: 36)
            }
        }
    }

    private var cleanMessage: String {
        let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedMessage.isEmpty ? ProductInfoText.failureFallbackMessage : trimmedMessage
    }
}
