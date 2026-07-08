//
//  SwiftUIView.swift
//  
//
//  Created by Eyad waleed on 07/07/2026.
//

import SwiftUI

struct DefaultAuthViewFactory: AuthViewFactory {
  
    
    func makeLoginView(
        onLoginSuccess: @escaping () -> Void,
        onRegisterTap: @escaping () -> Void,
        onGuestContinue : @escaping ()->Void
    ) -> AnyView {
        AnyView(
            LoginView(
                onNavigateToRegister: onRegisterTap, onGuestContinue: onGuestContinue,
                onLoginSuccess: onLoginSuccess,   viewModel: DIContainer.shared.resolver.resolve(LoginViewModel.self)!

                
            )
        )
    }

    func makeRegisterView(
        onRegisterSuccess: @escaping () -> Void,
        onBackToLoginTap: @escaping () -> Void,
        onGuestContinue : @escaping ()->Void

    ) -> AnyView {
        AnyView(
            RegisterView(
                onNavigateToLogin: onBackToLoginTap, onGuestContinue: onGuestContinue, onRegisterSuccess: onRegisterSuccess,
                registerViewModel: DIContainer.shared.resolver.resolve(RegisterViewModel.self)!
            )
        )
    }
}
