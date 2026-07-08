import SwiftUI

@MainActor
final class AuthFlowCoordinator: ObservableObject {
    @Published var path: [AuthFlowRoute] = []

    func showRoot() {
        path = []
    }
    
    func showRegister() {
        path.append(.register)
    }

    func popToLogin() {
        path.removeLast()
    }
}
