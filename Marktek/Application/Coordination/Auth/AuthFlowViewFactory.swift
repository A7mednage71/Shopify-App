import SwiftUI

struct AuthFlowViewFactory {
    @MainActor
    static func makeView(
        onAuthenticated: @escaping () -> Void
    ) -> AuthFlowView {
        AuthFlowView(onAuthenticated: onAuthenticated)
    }
}
