//
//  LoginView.swift
//
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI
import Common

@available(iOS 14.0, *)
public struct LoginView: View {
    @State var emailStateValue = ""
    @State var passwordStatValue = ""
    @StateObject var viewModel = LoginViewModel(signIn: SignInUseCase(Authrepo: AuthenticationRepositarory(firebaseAuth: FirebaseAuthenitcation(), apiAuth:ApiAuth.shared)),
   signInWithGoogle: SignWithGoogleUseCase(authRepo: AuthenticationRepositarory(firebaseAuth: FirebaseAuthenitcation(), apiAuth: ApiAuth.shared))
    )
    var onNavigateToRegister: () -> Void
    var onGuestContinue: () -> Void
    var onLoginSuccess: () -> Void

    public init(
            onNavigateToRegister: @escaping () -> Void = {},
            onGuestContinue: @escaping () -> Void = {},
            onLoginSuccess : @escaping () -> Void = {}
        ) {
            self.onNavigateToRegister = onNavigateToRegister
            self.onGuestContinue = onGuestContinue
            self.onLoginSuccess = onLoginSuccess
            
        }
    public var body: some View {
        ZStack {
            formContent
            if viewModel.loginState == .loading {
                loadingOverlay
            }
        }
        .alert(isPresented: Binding(
            get: {
                if case .error(_) = viewModel.loginState { return true }
                return false
            },
            set: { _ in viewModel.loginState = .idel }
        )) {
            var errorMessage = ""
            if case .error(let msg) = viewModel.loginState {
                errorMessage = msg
            }
            return Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }.onChange(of: viewModel.loginState) { newState in
            if newState == .success {
                onLoginSuccess()
            }
        }
    }
    
    
    @ViewBuilder
    private var formContent: some View {
        VStack {
            Group {
                Text("Welcome Back!").font(.system(size: 36, weight: .bold, design: .default))
                Spacer().frame(height: 85)
                FormField(label: "Email", icon: "envelope.fill", isError: !viewModel.emailError.isEmpty, formFieldState: $emailStateValue)
                if !viewModel.emailError.isEmpty {
                    Text(viewModel.emailError)
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 32)
                }
                Spacer().frame(height: 30)
                FormField(label: "Password", icon: "lock.fill", isSecureField: true, isError: !viewModel.passwordError.isEmpty, formFieldState: $passwordStatValue)
                if !viewModel.passwordError.isEmpty {
                    Text(viewModel.passwordError)
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 32)
                }
            }
            Group {
                Spacer().frame(height: 9)
                Button {
                } label: {
                    Text("Forget Password ?")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.primary)
                }
                .frame(maxWidth: .infinity, alignment: .trailing).padding(.horizontal , 30)
                Spacer().frame(height: 52)
                CustomBtn(label: "Login", action: {
                    Task {
                        await viewModel.login(email: emailStateValue, password: passwordStatValue)
                    }
                })
                Spacer().frame(height: 75)
            }
            Group {
                SocialSignInSection(
                    guestAction: {
                        onGuestContinue()
                    },
                    appleAction: {},
                    googleAction: {
                        Task {
                            await viewModel.signInWithGoogle()
                        }
                    }
                )
                Spacer().frame(height: 28)
                AuthBottomPrompt(
                    promptText: "Create An Account",
                    actionText: "Sign Up",
                    action: {
                        onNavigateToRegister()
                    }
                )
            }
        }
        .disabled(viewModel.loginState == .loading)
    }
    
    private var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
        }
    }
}
