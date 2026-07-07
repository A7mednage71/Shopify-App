import SwiftUI
import Settings
import Common

struct ProfileFlowView: View {
    let authState: AuthState
    let onPersonalInformationTap: () -> Void
    let onSavedAddressesTap: () -> Void
    let onOrdersTap: () -> Void

    var body: some View {
        SettingsViewFactory.makeView(
            authState: authState,
            onPersonalInformationTap: onPersonalInformationTap,
            onSavedAddressesTap: onSavedAddressesTap,
            onOrdersTap: onOrdersTap
        )
    }
}
