import SwiftUI

extension View {
    @ViewBuilder
    func cartNavigationTitleStyle() -> some View {
        #if os(iOS)
        navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }

    @ViewBuilder
    func cartNavigationContainerStyle() -> some View {
        #if os(iOS)
        navigationViewStyle(.stack)
        #else
        self
        #endif
    }
}
