import Common
import SwiftUI

struct CheckoutPrimaryButton: View {
    let title: String
    let isDisabled: Bool
    let action: () -> Void

    init(title: String, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(AppColors.textWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(isDisabled ? AppColors.textSecondary : AppColors.primary)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .shadow(color: (isDisabled ? Color.clear : AppColors.primary.opacity(0.28)), radius: 16, x: 0, y: 10)
        }
        .disabled(isDisabled)
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
