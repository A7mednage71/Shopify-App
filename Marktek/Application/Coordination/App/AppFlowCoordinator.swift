import SwiftUI

@MainActor
final class AppFlowCoordinator: ObservableObject {
    @Published var selectedFlow: AppFlow = .main

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
