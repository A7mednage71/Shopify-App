//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
import Common
@available(iOS 13.0.0, *)
class SignInUseCase{
    private let Authrepo : AuthRepoInterface
    init(Authrepo: AuthRepoInterface) {
        self.Authrepo = Authrepo
    }
    private func validate(email: String, password: String) throws {
        var emailError : String = ""
        var passwrodError : String = ""
        if email.isEmpty {
             emailError = L10n.Auth.validationEmailEmpty
        } else if !email.isValidEmail {
        emailError = L10n.Auth.validationEmailInvalid
        }
        if password.isEmpty {
            passwrodError = L10n.Auth.validationPasswordEmpty
        } else if password.count < 6 {
            passwrodError = L10n.Auth.validationPasswordMinLength
        }
        if(passwrodError.isEmpty && emailError.isEmpty){
            return
        }
        else{
            throw ValidateError(emailErrorMessage: emailError, passwordErrorMessage: passwrodError)
            
            
        }
    }

    func execute(email: String, password: String) async throws {
        try validate(email: email, password: password)
        try await Authrepo.signIn(email: email, password: password)
    }
}
struct ValidateError: Error {
    let emailErrorMessage: String
    let passwordErrorMessage : String
}
