import SwiftUI

public enum OnboardingViewFactory {
    @MainActor
    public static func makeOnboardingView(
        onFinish: @escaping () -> Void = {}
    ) -> some View {
        OnboardingView(onFinish: onFinish)
    }
}
