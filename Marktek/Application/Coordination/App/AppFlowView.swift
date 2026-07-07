import Common
import SwiftUI

struct AppFlowView: View {
    @ObservedObject private var authState: AuthState
    @StateObject private var coordinator: AppFlowCoordinator

    init(authState: AuthState) {
        self.authState = authState
        _coordinator = StateObject(
            wrappedValue: AppFlowCoordinator(shouldShowMainFlow: authState.shouldShowMainFlow)
        )
    }

    var body: some View {
        Group {
            switch coordinator.selectedFlow {
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
            if status == .unauthenticated {
                coordinator.showAuth()
            } else {
                coordinator.showMain()
            }
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
