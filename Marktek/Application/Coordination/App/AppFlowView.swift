import SwiftUI

struct AppFlowView: View {
    @StateObject private var coordinator = AppFlowCoordinator()

    var body: some View {
        switch coordinator.selectedFlow {
        case .auth:
            AuthFlowViewFactory.makeView(onAuthenticated: coordinator.showMain, onContinueAsGuest: coordinator.showMain
            )

        case .main:
            MainFlowViewFactory.makeView()
        }
    }
}
