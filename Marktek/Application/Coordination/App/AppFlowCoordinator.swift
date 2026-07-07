import SwiftUI

@MainActor
final class AppFlowCoordinator: ObservableObject {
    @Published var selectedFlow: AppFlow

    init(shouldShowOnboarding: Bool, shouldShowMainFlow: Bool) {
        if shouldShowOnboarding {
            selectedFlow = .onboarding
        } else {
            selectedFlow = shouldShowMainFlow ? .main : .auth
        }
    }

    func showOnboarding() {
        selectedFlow = .onboarding
    }

    func showAuth() {
        selectedFlow = .auth
    }

    func showMain() {
        selectedFlow = .main
    }
}

enum AppFlow: Hashable {
    case onboarding
    case auth
    case main
}
