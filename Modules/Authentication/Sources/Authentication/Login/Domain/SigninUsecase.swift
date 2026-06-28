//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
@available(iOS 13.0.0, *)
class SignInUseCase{
    private let Authrepo : AuthInterface
    init(Authrepo: AuthInterface) {
        self.Authrepo = Authrepo
    }
    private func validate(email: String, password: String) throws {
        var emailError : String = ""
        var passwrodError : String = ""
        if email.isEmpty {
             emailError = "Email cannot be empty"
        } else if !email.contains("@") {
        emailError = "Please enter a valid email"
        }
        if password.isEmpty {
            passwrodError = "Password cannot be empty"
        } else if password.count < 6 {
            passwrodError = "Password must be at least 6 characters"
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
