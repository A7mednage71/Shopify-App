import SwiftUI

struct OnboardingPrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                    .id(title)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))

                Image(systemName: "arrow.right")
                    .font(.system(size: 17, weight: .bold))
            }
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(OnboardingPalette.primary)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: OnboardingPalette.primary.opacity(0.28), radius: 16, x: 0, y: 10)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.22), value: title)
        .accessibilityLabel(title)
    }
}


