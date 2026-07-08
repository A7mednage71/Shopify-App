//
//  SwiftUIView 2.swift
//
//
//  Created by Esraa Ehab on 29/06/2026.
//

import SwiftUI
import Common

@available(iOS 14.0, *)
 struct RegisterView: View {
    @State var fullNameStateValue = ""
    @State var emailStateValue = ""
    @State var passwordStateValue = ""
    @State var confirmPasswordStateValue = ""
    
    @ObservedObject var viewModel : RegisterViewModel
    
    var onNavigateToLogin: () -> Void
    var onGuestContinue: () -> Void
    var onRegisterSuccess: ()-> Void

     init(
        onNavigateToLogin: @escaping () -> Void = {},
        onGuestContinue: @escaping () -> Void = {}
        , onRegisterSuccess : @escaping() -> Void = {}
        , registerViewModel : RegisterViewModel
    ) {
        self.onNavigateToLogin = onNavigateToLogin
        self.onGuestContinue = onGuestContinue
        self.onRegisterSuccess  = onRegisterSuccess
        self.viewModel = registerViewModel
     }


    
     var body: some View {
        ZStack {
            formContent
            
            if viewModel.registerState == .loading {
                loadingOverlay
            }
        }
        .alert(isPresented: Binding(
            get: {
                if case .error(_) = viewModel.registerState { return true }
                return false
            },
            set: { _ in viewModel.registerState = .idel }
        )) {
            var errorMessage = ""
            if case .error(let msg) = viewModel.registerState {
                errorMessage = msg
            }
            return Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }.onChange(of: viewModel.registerState) { newState in
            if newState == .success {
                onRegisterSuccess()
            }
        }
    }
    
    @ViewBuilder
    private var formContent: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                headerSection
                fieldsSection
                agreementAndSubmitSection
                socialAndFooterSection
            }
            .padding(.bottom, 20)
        }
        .disabled(viewModel.registerState == .loading)
    }

    @ViewBuilder
    private var headerSection: some View {
        Text("Create an\naccount")
            .font(.system(size: 36, weight: .bold, design: .default))
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 32)
            .padding(.top, 20)
    }

    @ViewBuilder
    private var fieldsSection: some View {
        Group {
            Spacer().frame(height: 35)

            FormField(label: "Full Name", icon: "person.fill", isError: !viewModel.nameError.isEmpty, formFieldState: $fullNameStateValue)
            if !viewModel.nameError.isEmpty {
                errorText(viewModel.nameError)
            }

            Spacer().frame(height: 15)

            FormField(label: "Username or Email", icon: "envelope.fill", isError: !viewModel.emailError.isEmpty, formFieldState: $emailStateValue)
            if !viewModel.emailError.isEmpty {
                errorText(viewModel.emailError)
            }
        }

        Group {
            Spacer().frame(height: 15)

            FormField(label: "Password", icon: "lock.fill", isSecureField: true, isError: !viewModel.passwordError.isEmpty, formFieldState: $passwordStateValue)
            if !viewModel.passwordError.isEmpty {
                errorText(viewModel.passwordError)
            }

            Spacer().frame(height: 15)

            FormField(label: "Confirm Password", icon: "lock.fill", isSecureField: true, isError: !viewModel.confirmPasswordError.isEmpty, formFieldState: $confirmPasswordStateValue)
            if !viewModel.confirmPasswordError.isEmpty {
                errorText(viewModel.confirmPasswordError)
            }
        }
    }

    @ViewBuilder
    private var agreementAndSubmitSection: some View {
        Spacer().frame(height: 15)

        (Text("By clicking the ")
            .foregroundColor(AppColors.textSecondary)
            .font(.system(size: 12))
        + Text("Register ")
            .foregroundColor(AppColors.primary)
            .font(.system(size: 12))
        + Text("button, you agree\nto the public offer")
            .foregroundColor(AppColors.textSecondary)
            .font(.system(size: 12)))
        .multilineTextAlignment(.center)
        .padding(.horizontal, 32)

        Spacer().frame(height: 35)

        CustomBtn(label: "Create Account", action: {
            Task {
                await viewModel.register(
                    fullName: fullNameStateValue,
                    email: emailStateValue,
                    password: passwordStateValue,
                    confirmPassword: confirmPasswordStateValue
                )
            }
        })

        Spacer().frame(height: 40)
    }

    @ViewBuilder
    private var socialAndFooterSection: some View {
        SocialSignInSection(
            guestAction: {
                onGuestContinue()
            },
            appleAction: {},
            googleAction: {
                Task {
                    await viewModel.registerWithGoogle()
                }
            }
        )

        Spacer().frame(height: 28)

        AuthBottomPrompt(
            promptText: "I Already Have an Account",
            actionText: "Login",
            action: {
                onNavigateToLogin()
            }
        )
        Spacer().frame(height: 20)
    }

    private func errorText(_ message: String) -> some View {
        Text(message)
            .font(.system(size: 12))
            .foregroundColor(AppColors.error)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 32)
    }
    
    private var loadingOverlay: some View {
        ZStack {
            AppColors.shadow.opacity(0.3)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: AppColors.primary))
                .scaleEffect(1.5)
        }
    }
}
