//
//  SwiftUIView.swift
//  
//
//  Created by Eyad waleed on 02/07/2026.
//
import SwiftUI
enum AuthRoute: Hashable {
    case login
    case register
}

public struct AuthFlowView: View {
    @State private var currentAuthScreen: AuthRoute = .login
     
    let onAuthenticated: () -> Void
    let onContinueAsGuest: () -> Void
    
    public init(
        onAuthenticated: @escaping () -> Void,
        onContinueAsGuest: @escaping () -> Void
    ) {
        self.onAuthenticated = onAuthenticated
        self.onContinueAsGuest = onContinueAsGuest}
        
    public var body: some View {
                    Group {
                        switch currentAuthScreen {
                        case .login:
                            LoginView(
                                onNavigateToRegister: {
                                    currentAuthScreen = .register
                                },
                                onGuestContinue: {
                                    onContinueAsGuest()
                                },
                                onLoginSuccess: {
                                    onAuthenticated()
                                }
                            )
                        case .register:
                            RegisterView(
                                onNavigateToLogin: {
                                    currentAuthScreen = .login
                                },
                                onGuestContinue: {
                                    onContinueAsGuest()
                                },
                                onRegisterSuccess: {
                                    currentAuthScreen = .login
                                }
                            )
                        }
                    }
      
    }
    }

