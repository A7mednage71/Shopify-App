import Common
import SwiftUI

struct CheckoutPrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(AppColors.textWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(AppColors.primary)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .shadow(color: AppColors.primary.opacity(0.28), radius: 16, x: 0, y: 10)
        }
        .buttonStyle(CheckoutPrimaryButtonStyle())
        .accessibilityLabel(title)
    }
}

private struct CheckoutPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}
