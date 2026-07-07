import Common
import SwiftUI

struct AppRootView: View {
    @StateObject private var authState = AuthState()

    var body: some View {
        AppFlowViewFactory.makeView(authState: authState)
    }
}
