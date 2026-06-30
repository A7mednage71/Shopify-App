import SwiftUI

extension View {
    func cartNavigationTitleStyle() -> some View {
        navigationBarTitleDisplayMode(.inline)
    }

    func cartNavigationContainerStyle() -> some View {
        navigationViewStyle(.stack)
    }
}
