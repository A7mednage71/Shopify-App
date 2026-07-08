//
//  File.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import Foundation
import Common
@available(iOS 13.0, *)
@MainActor
class LoginViewModel : ObservableObject{
   let  signIn : SignInUseCase
    let signInWithGoogle : SignWithGoogleUseCase
    
    @Published var loginState  : AuthState = .idel
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    init(signIn: SignInUseCase , signInWithGoogle : SignWithGoogleUseCase) {
        self.signIn = signIn
        self.signInWithGoogle = signInWithGoogle
    }
    func login(email :String , password : String) async {
        emailError = ""
        passwordError = ""
        do{
            loginState = .loading
            try await signIn.execute(email: email , password: password)
            loginState = .success
        } catch let error as  ValidateError {
            loginState = .idel
            emailError = error.emailErrorMessage
            passwordError = error.passwordErrorMessage
        }
        catch  {
            loginState = .error(handleAuthError(error))
        }
    }
    func signInWithGoogle() async {
        do {
            loginState = .loading
            try await signInWithGoogle.execute()
            loginState = .success
        } catch  {
            loginState = .error(handleAuthError(error))
        } catch {
            loginState = .error(L10n.Auth.errorSomethingWentWrong)
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
