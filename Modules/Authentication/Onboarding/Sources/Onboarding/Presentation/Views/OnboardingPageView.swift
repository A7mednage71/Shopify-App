import SwiftUI

struct OnboardingPageView: View {
    let item: OnboardingItem
    let isActive: Bool
    let isFloating: Bool
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 26) {
                Spacer(minLength: 8)

                imageCard(height: imageHeight(for: geometry.size))

                VStack(spacing: 12) {
                    Text(item.title)
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(OnboardingPalette.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                        .minimumScaleFactor(0.82)

                    Text(item.description)
                        .font(.system(size: 17, weight: .regular))
                        .lineSpacing(4)
                        .multilineTextAlignment(.center)
                        .foregroundColor(OnboardingPalette.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 6)

                Spacer(minLength: 8)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }

    private func imageCard(height: CGFloat) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(OnboardingPalette.imageBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .stroke(OnboardingPalette.cardBackground.opacity(0.9), lineWidth: 1)
                )
                .shadow(color: OnboardingPalette.shadow, radius: 22, x: 0, y: 14)

            Image(item.imageName, bundle: .module)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .accessibilityHidden(true)
        }
        .frame(height: height)
        .scaleEffect(isActive ? 1 : 0.94)
        .opacity(isActive ? 1 : 0.55)
        .offset(y: reduceMotion ? 0 : (isFloating ? -8 : 5))
        .animation(.spring(response: 0.44, dampingFraction: 0.86), value: isActive)
        .animation(reduceMotion ? nil : .easeInOut(duration: 1.7), value: isFloating)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(item.title)
    }

    private func imageHeight(for size: CGSize) -> CGFloat {
        let targetHeight = size.height * 0.58
        return min(max(targetHeight, 260), 450)
    }
}

#Preview {
    OnboardingPageView(
        item: OnboardingItem.defaults[0],
        isActive: true,
        isFloating: false,
        reduceMotion: false
    )
    .padding(24)
    .background(OnboardingPalette.pageBackground)
}
