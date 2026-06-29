//
//  File.swift
//  
//
//  Created by Esraa Ehab on 29/06/2026.
//

import Foundation

@available(iOS 13.0, *)
@MainActor
class RegisterViewModel: ObservableObject {
    
    let registerUseCase: RegisterUseCase
    let signInWithGoogle: SignWithGoogleUseCase
    
    @Published var registerState: AuthState = .idel
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    @Published var confirmPasswordError: String = ""
    
    init(registerUseCase: RegisterUseCase, signInWithGoogle: SignWithGoogleUseCase) {
        self.registerUseCase = registerUseCase
        self.signInWithGoogle = signInWithGoogle
    }
    
    func register(email: String, password: String, confirmPassword: String) async {
        emailError = ""
        passwordError = ""
        confirmPasswordError = ""
        
        do {
            registerState = .loading
            try await registerUseCase.execute(email: email, password: password, confirmPassword: confirmPassword)
            registerState = .success
            
        } catch let error as RegisterValidateError {
            registerState = .idel
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
            return "Try again later"
        }
        
        switch authError {
        case .invalidCredentials:
            return "Invalid email or password"
        case .userNotFound:
            return "No account found with this email"
        case .emailAlreadyInUse:
            return "Email is already registered"
        case .networkError:
            return "Check your internet connection"
        case .unknown:
            return "Unknown Error"
        }
    }
}
