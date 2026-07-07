import SwiftUI

@MainActor
final class AppFlowCoordinator: ObservableObject {
    @Published var selectedFlow: AppFlow

    init(shouldShowMainFlow: Bool) {
        selectedFlow = shouldShowMainFlow ? .main : .auth
    }

    func showAuth() {
        selectedFlow = .auth
    }

    func showMain() {
        selectedFlow = .main
    }
}

enum AppFlow: Hashable {
    case auth
    case main
}
