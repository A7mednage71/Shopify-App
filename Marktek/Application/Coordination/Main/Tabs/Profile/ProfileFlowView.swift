import SwiftUI
import Settings

struct ProfileFlowView: View {
    let onOrdersTap: () -> Void

        var body: some View {
            SettingsViewFactory.makeView(onOrdersTap: onOrdersTap)
        }
}
