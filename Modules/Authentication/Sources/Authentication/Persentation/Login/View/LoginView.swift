import SwiftUI
import Common
import Combine
import UIKit

@available(iOS 15.0, *)
struct LoginView: View {
    @State var emailStateValue = ""
    @State var passwordStatValue = ""
    @ObservedObject var viewModel: LoginViewModel
    var onNavigateToRegister: () -> Void
    var onGuestContinue: () -> Void
    var onLoginSuccess: () -> Void

    init(
        onNavigateToRegister: @escaping () -> Void = {},
        onGuestContinue: @escaping () -> Void = {},
        onLoginSuccess: @escaping () -> Void = {},
        viewModel: LoginViewModel
    ) {
        self.onNavigateToRegister = onNavigateToRegister
        self.onGuestContinue = onGuestContinue
        self.onLoginSuccess = onLoginSuccess
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 1. Hero Section
                heroSection
                
                formContent
                    .padding(.bottom, 24)
            }
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .ignoresSafeArea(.container, edges: .top)
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
                title: Text(L10n.Auth.error),
                message: Text(errorMessage),
                dismissButton: .default(Text(L10n.Auth.ok))
            )
        }
        .onChange(of: viewModel.loginState) { newState in
            if newState == .success {
                onLoginSuccess()
            }
        }
    }

    private var heroSection: some View {
        ZStack {
            LinearGradient(
                colors: [AppColors.authHeroGradientStart, Color(.systemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 230)
            .clipShape(CustomRoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight]))
            
            Circle()
                .fill(Color.white)
                .frame(width: 104, height: 104)
                .shadow(color: AppColors.primary.opacity(0.18), radius: 10, x: 0, y: 5)
                .overlay(
                    AppImages.appIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2.5)
                        )
                )
                .padding(.top, 40)
        }
        .frame(height: 230)
    }

    @ViewBuilder
    private var formContent: some View {
        VStack(spacing: 0) {
            VStack(spacing: 6) {
                Text(L10n.Auth.welcomeBack)
                    .font(AppFonts.authTitle)
                    .foregroundColor(AppColors.textPrimary)
                
                Text(L10n.Auth.loginDescription)
                    .font(AppFonts.authSubtitle)
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 4)
            }
            .padding(.top, 12)
            .padding(.bottom, 36)

            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    FormField(
                        label: L10n.Auth.emailFieldLabel,
                        icon: "envelope.fill",
                        isError: !viewModel.emailError.isEmpty,
                        formFieldState: $emailStateValue
                    )
                    
                    if !viewModel.emailError.isEmpty {
                        Text(viewModel.emailError)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(AppColors.error)
                            .padding(.horizontal, 40)
                            .transition(.opacity)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    FormField(
                        label: L10n.Auth.passwordFieldLabel,
                        icon: "lock.fill",
                        isSecureField: true,
                        isError: !viewModel.passwordError.isEmpty,
                        formFieldState: $passwordStatValue
                    )
                    
                    if !viewModel.passwordError.isEmpty {
                        Text(viewModel.passwordError)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(AppColors.error)
                            .padding(.horizontal, 40)
                            .transition(.opacity)
                    }
                }
            }

            HStack {
                Spacer()
                Button {
                    // Forget password logic
                } label: {
                    Text(L10n.Auth.forgetPassword)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
                .padding(.trailing, 32)
            }
            .padding(.top, 12)
            .padding(.bottom, 32)

            CustomBtn(
                label: L10n.Auth.login,
                isLoading: viewModel.loginState == .loading,
                action: {
                    Task {
                        await viewModel.login(email: emailStateValue, password: passwordStatValue)
                    }
                }
            )

            HStack {
                VStack { Divider().background(AppColors.authDivider) }
                Text(L10n.Auth.orWith)
                    .font(AppFonts.authEyebrow)
                    .tracking(1.5)
                    .foregroundColor(AppColors.textSecondary.opacity(0.8))
                    .padding(.horizontal, 12)
                VStack { Divider().background(AppColors.authDivider) }
            }
            .padding(.horizontal, 32)
            .padding(.top, 40)
            .padding(.bottom, 24)

            VStack(spacing: 32) {
                HStack(spacing: 24) {
                    CutomeCircularBtn(image: "person.crop.circle.fill.badge.plus", label: "", action: onGuestContinue)
                    CutomeCircularBtn(image: "google", action: {
                        Task {
                            await viewModel.signInWithGoogle()
                        }
                    })
                }
                
                AuthBottomPrompt(
                    promptText: L10n.Auth.createAccountPrompt + "?",
                    actionText: L10n.Auth.signUpAction,
                    action: {
                        onNavigateToRegister()
                    }
                )
            }
        }
        .disabled(viewModel.loginState == .loading)
    }
}
