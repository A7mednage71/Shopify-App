//
//  AuthViewFactory.swift
//  Marktek
//
//  Created by Eyad waleed on 07/07/2026.
//

import Foundation
import SwiftUI

@MainActor
public protocol AuthViewFactory {
    func makeLoginView(
        onLoginSuccess: @escaping () -> Void,
        onRegisterTap: @escaping () -> Void,
        onGuestContinue : @escaping ()->Void
    ) -> AnyView

    func makeRegisterView(
        onRegisterSuccess: @escaping () -> Void,
        onBackToLoginTap: @escaping () -> Void,
        onGuestContinue : @escaping ()->Void

    ) -> AnyView 
}

