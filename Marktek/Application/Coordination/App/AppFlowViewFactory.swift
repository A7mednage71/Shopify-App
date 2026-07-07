import SwiftUI
import Common

struct AppFlowViewFactory {
    @MainActor
    static func makeView(authState: AuthState) -> AppFlowView {
        AppFlowView(authState: authState)
    }
}
