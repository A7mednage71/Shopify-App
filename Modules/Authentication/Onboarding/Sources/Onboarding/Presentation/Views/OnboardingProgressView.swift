import SwiftUI
import Common

struct OnboardingProgressView: View {
    let currentIndex: Int
    let totalCount: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalCount, id: \.self) { index in
                Capsule()
                    .fill(index == currentIndex ? OnboardingPalette.primary : OnboardingPalette.border)
                    .frame(width: index == currentIndex ? 26 : 8, height: 8)
                    .animation(.spring(response: 0.35, dampingFraction: 0.82), value: currentIndex)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(L10n.Onboarding.pageAccessibilityLabel(currentIndex: currentIndex + 1, totalCount: totalCount))
    }
}

#Preview {
    OnboardingProgressView(currentIndex: 1, totalCount: 3)
        .padding()
        .background(OnboardingPalette.pageBackground)
}
