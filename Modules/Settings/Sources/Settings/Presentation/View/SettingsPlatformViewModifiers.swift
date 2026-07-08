import SwiftUI

#if os(iOS)
import UIKit
#endif

enum SettingsKeyboardKind {
    case `default`
    case emailAddress
    case phonePad
}

enum SettingsTextAutocapitalizationKind {
    case words
    case never
}

extension View {
    @ViewBuilder
    func settingsKeyboardType(_ kind: SettingsKeyboardKind) -> some View {
        #if os(iOS)
        switch kind {
        case .default:
            keyboardType(.default)
        case .emailAddress:
            keyboardType(.emailAddress)
        case .phonePad:
            keyboardType(.phonePad)
        }
        #else
        self
        #endif
    }

    @ViewBuilder
    func settingsTextInputAutocapitalization(_ kind: SettingsTextAutocapitalizationKind) -> some View {
        #if os(iOS)
        switch kind {
        case .words:
            textInputAutocapitalization(.words)
        case .never:
            textInputAutocapitalization(.never)
        }
        #else
        self
        #endif
    }

    @ViewBuilder
    func settingsNavigationBarHidden(_ hidden: Bool) -> some View {
        #if os(iOS)
        navigationBarHidden(hidden)
        #else
        self
        #endif
    }

    @ViewBuilder
    func settingsInlineNavigationTitle() -> some View {
        #if os(iOS)
        navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }
}
