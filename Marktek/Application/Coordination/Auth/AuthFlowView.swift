import SwiftUI

import SwiftUI
import Authentication
import SwiftUI
import Authentication

struct AuthFlowView: View {
    @StateObject private var coordinator = AuthFlowCoordinator()
    let onAuthenticated: () -> Void
    let onContinueAsGuest: () -> Void

    private let factory = AuthFeatureViewFactoryResolver.resolveAuthViewFactory()
    

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            factory.makeLoginView(
                onLoginSuccess: onAuthenticated,
                onRegisterTap: coordinator.showRegister, onGuestContinue: onContinueAsGuest
            )
            .navigationDestination(for: AuthFlowRoute.self) { route in
                destination(for: route)
            }
        }
    }

    @ViewBuilder
    private func destination(for route: AuthFlowRoute) -> some View {
        switch route {
        case .register:
            factory.makeRegisterView(
                onRegisterSuccess: onAuthenticated,
                onBackToLoginTap: coordinator.popToLogin, onGuestContinue: onContinueAsGuest
            )
        }
    }
}
