//
//  File.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import Foundation
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
            loginState = .error("Something went wrong")
        }
    }
    private func handleAuthError(_ error: Error) -> String {
        guard let authError = error as? AuthError else {
            return "try again later "
            
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
            return"Unknown Error"
        case .unknowns:
            return "Unknown Erorr"
        }
    }
    
    
    
}
