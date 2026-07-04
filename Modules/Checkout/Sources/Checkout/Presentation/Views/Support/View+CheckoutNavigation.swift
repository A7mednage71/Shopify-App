import SwiftUI

extension View {
    func checkoutNavigationTitleStyle() -> some View {
        #if os(iOS)
        return navigationBarTitleDisplayMode(.inline)
        #else
        return self
        #endif
    }
}
