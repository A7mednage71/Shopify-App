//
//  File.swift
//  
//
//  Created by Esraa Ehab on 29/06/2026.
//

import Foundation

@available(iOS 13.0.0, *)
class RegisterUseCase {
    private let authRepo: AuthRepoInterface
    
    init(authRepo: AuthRepoInterface) {
        self.authRepo = authRepo
    }
    
    private func validate(email: String, password: String, confirmPassword: String) throws {
        var emailError: String = ""
        var passwordError: String = ""
        var confirmPasswordError: String = ""
        
        if email.isEmpty {
            emailError = "Email cannot be empty"
        } else if !email.contains("@") {
            emailError = "Please enter a valid email"
        }
        
        if password.isEmpty {
            passwordError = "Password cannot be empty"
        } else if password.count < 6 {
            passwordError = "Password must be at least 6 characters"
        }
        
        if confirmPassword.isEmpty {
            confirmPasswordError = "Confirm Password cannot be empty"
        } else if password != confirmPassword {
            confirmPasswordError = "Passwords do not match"
        }
        
        if emailError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty {
            return
        } else {
            throw RegisterValidateError(
                emailErrorMessage: emailError,
                passwordErrorMessage: passwordError,
                confirmPasswordErrorMessage: confirmPasswordError
            )
        }
    }

    func execute(email: String, password: String, confirmPassword: String) async throws {
        try validate(email: email, password: password, confirmPassword: confirmPassword)
        try await authRepo.createUserWithEmailAndPassword(email: email, password: password)
    }
}

struct RegisterValidateError: Error {
    let emailErrorMessage: String
    let passwordErrorMessage: String
    let confirmPasswordErrorMessage: String
}
