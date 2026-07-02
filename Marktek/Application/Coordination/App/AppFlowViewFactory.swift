import SwiftUI

struct AppFlowViewFactory {
    @MainActor
    static func makeView() -> AppFlowView {
        AppFlowView()
    }
}
