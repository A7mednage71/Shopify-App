import Common
import SwiftUI

struct CartPrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                Image(systemName: "arrow.right")
                    .font(.system(size: 17, weight: .bold))
            }
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(AppColors.textWhite)
            .frame(maxWidth: 240)
            .frame(height: 50)
            .background(AppColors.primary)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: AppColors.primary.opacity(0.15), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(CartPrimaryButtonStyle())
        .accessibilityLabel(title)
    }
}

private struct CartPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}
