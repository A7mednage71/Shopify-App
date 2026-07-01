import Common
import SwiftUI

struct CartEmptyView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 22)

            Image(CartText.emptyImageName, bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 300)
                .padding(.horizontal, 26)
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

            CartPrimaryButton(title: CartText.startShoppingButtonTitle, action: {})
                .padding(.horizontal, 22)
                .padding(.top, 8)

            Spacer(minLength: 42)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
