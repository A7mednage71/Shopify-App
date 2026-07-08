//
//  File.swift
//
//
//  Created by Esraa Ehab on 29/06/2026.
//

import Foundation
import Common

@available(iOS 13.0, *)
@MainActor
class RegisterViewModel: ObservableObject {
    
    let registerUseCase: RegisterUseCase
    let signInWithGoogle: SignWithGoogleUseCase
    
    @Published var registerState: AuthState = .idel
    @Published var emailError: String = ""
    @Published var nameError: String = ""
    @Published var passwordError: String = ""
    @Published var confirmPasswordError: String = ""
    
    init(registerUseCase: RegisterUseCase, signInWithGoogle: SignWithGoogleUseCase) {
        self.registerUseCase = registerUseCase
        self.signInWithGoogle = signInWithGoogle
    }
    
    func register(fullName: String, email: String, password: String, confirmPassword: String) async {
        nameError = ""
        emailError = ""
        passwordError = ""
        confirmPasswordError = ""
        
        do {
            registerState = .loading
            try await registerUseCase.execute(fullName: fullName, email: email, password: password, confirmPassword: confirmPassword)
            registerState = .success
            
        } catch let error as RegisterValidateError {
            registerState = .idel
            nameError = error.fullNameErrorMessage
            emailError = error.emailErrorMessage
            passwordError = error.passwordErrorMessage
            confirmPasswordError = error.confirmPasswordErrorMessage
            
        } catch {
            registerState = .error(handleAuthError(error))
        }
    }
    
    func registerWithGoogle() async {
        do {
            registerState = .loading
            try await signInWithGoogle.execute()
            registerState = .success
        } catch {
            registerState = .error(handleAuthError(error))
        }
    }
    
    private func handleAuthError(_ error: Error) -> String {
        guard let authError = error as? AuthError else {
            return L10n.Auth.errorTryAgainLater
        }
        
        switch authError {
        case .invalidCredentials:
            return L10n.Auth.errorInvalidCredentials
        case .userNotFound:
            return L10n.Auth.errorUserNotFound
        case .emailAlreadyInUse:
            return L10n.Auth.errorEmailAlreadyRegistered
        case .networkError:
            return L10n.Auth.errorNetwork
        case .unknown:
            return L10n.Auth.errorUnknown
        case .unknowns:
            return L10n.Auth.errorUnknown
        }
    }
}
