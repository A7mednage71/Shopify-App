import SwiftUI

struct AuthFlowView: View {
    @StateObject private var coordinator = AuthFlowCoordinator()
    let onAuthenticated: () -> Void

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            EmptyView()
        }
    }
}
