import Common
import Foundation
import Onboarding
import SwiftUI

struct AppFlowView: View {
    private static let onboardingCompletionKey = "hasCompletedOnboarding"

    @ObservedObject private var authState: AuthState
    @StateObject private var coordinator: AppFlowCoordinator
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    init(authState: AuthState) {
        self.authState = authState
        _coordinator = StateObject(
            wrappedValue: AppFlowCoordinator(
                shouldShowOnboarding: !UserDefaults.standard.bool(forKey: Self.onboardingCompletionKey),
                shouldShowMainFlow: authState.shouldShowMainFlow
            )
        )
    }

    var body: some View {
        Group {
            switch coordinator.selectedFlow {
            case .onboarding:
                OnboardingViewFactory.makeOnboardingView(onFinish: completeOnboarding)

            case .auth:
                AuthFlowViewFactory.makeView(
                    onAuthenticated: showMainAfterAuthentication,
                    onContinueAsGuest: showMainAsGuest
                )

            case .main:
                MainFlowViewFactory.makeView(authState: authState)
            }
        }
        .onChange(of: authState.sessionStatus) { status in
            guard hasCompletedOnboarding else {
                coordinator.showOnboarding()
                return
            }

            if status == .unauthenticated {
                coordinator.showAuth()
            } else {
                coordinator.showMain()
            }
        }
    }

    private func completeOnboarding() {
        hasCompletedOnboarding = true

        if authState.shouldShowMainFlow {
            coordinator.showMain()
        } else {
            coordinator.showAuth()
        }
    }

    private func showMainAfterAuthentication() {
        authState.markLoggedIn()
        coordinator.showMain()
    }

    private func showMainAsGuest() {
        authState.markGuest()
        coordinator.showMain()
    }
}
