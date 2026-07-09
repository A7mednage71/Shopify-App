import Common
import SwiftUI

struct CartEmptyView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var illustrationScale: CGFloat = 0.98
    let onStartShoppingTap: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 22)

            Image(CartText.emptyImageName, bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.horizontal, 26)
                .scaleEffect(illustrationScale)
                .onAppear {
                    startIllustrationAnimation()
                }
                .onChange(of: reduceMotion) { _ in
                    startIllustrationAnimation()
                }
                .transition(.opacity.combined(with: .scale(scale: 0.96)))

            VStack(spacing: 8) {
                Text(CartText.emptyTitle)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(CartText.emptyMessage)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .padding(.horizontal, 30)

            CartPrimaryButton(
                title: CartText.startShoppingButtonTitle,
                action: onStartShoppingTap
            )
                .padding(.horizontal, 22)
                .padding(.top, 8)

            Spacer(minLength: 42)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func startIllustrationAnimation() {
        guard !reduceMotion else {
            illustrationScale = 1.0
            return
        }

        illustrationScale = 0.98
        withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
            illustrationScale = 1.03
        }
    }
}
