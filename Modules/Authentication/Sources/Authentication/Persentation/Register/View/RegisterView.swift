import SwiftUI
import Common
import UIKit

@available(iOS 15.0, *)
struct RegisterView: View {
    @State var fullNameStateValue = ""
    @State var emailStateValue = ""
    @State var passwordStateValue = ""
    @State var confirmPasswordStateValue = ""
    
    @ObservedObject var viewModel: RegisterViewModel
    
    var onNavigateToLogin: () -> Void
    var onGuestContinue: () -> Void
    var onRegisterSuccess: () -> Void

    init(
        onNavigateToLogin: @escaping () -> Void = {},
        onGuestContinue: @escaping () -> Void = {},
        onRegisterSuccess: @escaping () -> Void = {},
        registerViewModel: RegisterViewModel
    ) {
        self.onNavigateToLogin = onNavigateToLogin
        self.onGuestContinue = onGuestContinue
        self.onRegisterSuccess = onRegisterSuccess
        self.viewModel = registerViewModel
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
                title: Text(L10n.Auth.error),
                message: Text(errorMessage),
                dismissButton: .default(Text(L10n.Auth.ok))
            )
        }
        .onChange(of: viewModel.registerState) { newState in
            if newState == .success {
                onRegisterSuccess()
            }
        }
    }

    // الـ Hero Section بارتفاع 230px وخلفية Peach وبها AppIcon
    private var heroSection: some View {
        ZStack {
            LinearGradient(
                colors: [AppColors.authHeroGradientStart, Color(.systemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 230)
            .clipShape(CustomRoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight]))
            
            // الدائرة البيضاء وبداخلها الـ AppIcon
            Circle()
                .fill(Color.white)
                .frame(width: 104, height: 104)
                .shadow(color: AppColors.primary.opacity(0.18), radius: 10, x: 0, y: 5)
                .overlay(
                    Image("AppIcon", bundle: .module)
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
            // 2. العنوان مع الجملة الوصفية الترحيبية بالأبليكيشن
            VStack(spacing: 6) {
                Text(L10n.Auth.createAccount)
                    .font(AppFonts.authTitle)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Join us to explore the latest fashion trends and get smart shopping suggestions.")
                    .font(AppFonts.authSubtitle)
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 4)
            }
            .padding(.top, 12)
            .padding(.bottom, 24)

            // 3. حقول الإدخال
            VStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    FormField(
                        label: L10n.Auth.fullNameFieldLabel,
                        icon: "person.fill",
                        isError: !viewModel.nameError.isEmpty,
                        formFieldState: $fullNameStateValue
                    )
                    
                    if !viewModel.nameError.isEmpty {
                        errorText(viewModel.nameError)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    FormField(
                        label: L10n.Auth.usernameOrEmailFieldLabel,
                        icon: "envelope.fill",
                        isError: !viewModel.emailError.isEmpty,
                        formFieldState: $emailStateValue
                    )
                    
                    if !viewModel.emailError.isEmpty {
                        errorText(viewModel.emailError)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    FormField(
                        label: L10n.Auth.passwordFieldLabel,
                        icon: "lock.fill",
                        isSecureField: true,
                        isError: !viewModel.passwordError.isEmpty,
                        formFieldState: $passwordStateValue
                    )
                    
                    if !viewModel.passwordError.isEmpty {
                        errorText(viewModel.passwordError)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    FormField(
                        label: L10n.Auth.confirmPasswordFieldLabel,
                        icon: "lock.fill",
                        isSecureField: true,
                        isError: !viewModel.confirmPasswordError.isEmpty,
                        formFieldState: $confirmPasswordStateValue
                    )
                    
                    if !viewModel.confirmPasswordError.isEmpty {
                        errorText(viewModel.confirmPasswordError)
                    }
                }
            }

            // شروط الخدمة والاتفاقية
            VStack(spacing: 0) {
                (Text(L10n.Auth.byClicking)
                    .foregroundColor(AppColors.textSecondary)
                    .font(.system(size: 11, weight: .medium))
                + Text(L10n.Auth.register)
                    .foregroundColor(AppColors.primary)
                    .font(.system(size: 11, weight: .bold))
                + Text(L10n.Auth.agreePublicOffer)
                    .foregroundColor(AppColors.textSecondary)
                    .font(.system(size: 11, weight: .medium)))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            }
            .padding(.top, 16)
            .padding(.bottom, 28)

            // 4. زر التسجيل مع الـ Loading المدمج فيه
            CustomBtn(
                label: L10n.Auth.createAccount,
                isLoading: viewModel.registerState == .loading,
                action: {
                    Task {
                        await viewModel.register(
                            fullName: fullNameStateValue,
                            email: emailStateValue,
                            password: passwordStateValue,
                            confirmPassword: confirmPasswordStateValue
                        )
                    }
                }
            )

            // 5. الفاصل الـ Divider الأنيق مكتوب عليه "OR WITH"
            HStack {
                VStack { Divider().background(AppColors.authDivider) }
                Text("OR WITH")
                    .font(AppFonts.authEyebrow)
                    .tracking(1.5)
                    .foregroundColor(AppColors.textSecondary.opacity(0.8))
                    .padding(.horizontal, 12)
                VStack { Divider().background(AppColors.authDivider) }
            }
            .padding(.horizontal, 32)
            .padding(.top, 36)
            .padding(.bottom, 24)

            // 6. أيقونات Guest و Google
            VStack(spacing: 32) {
                HStack(spacing: 24) {
                    CutomeCircularBtn(image: "person.crop.circle.fill.badge.plus", label: "", action: onGuestContinue)
                    CutomeCircularBtn(image: "google", action: {
                        Task {
                            await viewModel.registerWithGoogle()
                        }
                    })
                }
                
                AuthBottomPrompt(
                    promptText: L10n.Auth.alreadyHaveAccountPrompt + "?",
                    actionText: L10n.Auth.loginAction,
                    action: {
                        onNavigateToLogin()
                    }
                )
            }
        }
        .disabled(viewModel.registerState == .loading)
    }

    private func errorText(_ message: String) -> some View {
        Text(message)
            .font(.system(size: 11, weight: .medium))
            .foregroundColor(AppColors.error)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            .transition(.opacity)
    }
}
