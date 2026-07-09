//
//  File.swift
//
//
//  Created by Esraa Ehab on 29/06/2026.
//

import Foundation
import Common

@available(iOS 13.0.0, *)
class RegisterUseCase {
    private let authRepo: AuthRepoInterface
    
    init(authRepo: AuthRepoInterface) {
        self.authRepo = authRepo
    }
    
    private func validate(fullName: String, email: String, password: String, confirmPassword: String) throws {
        var fullNameError: String = ""
        var emailError: String = ""
        var passwordError: String = ""
        var confirmPasswordError: String = ""
        
        let trimmedFullName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedFullName.isEmpty {
            fullNameError = L10n.Auth.validationNameEmpty
        }
        
        if email.isEmpty {
            emailError = L10n.Auth.validationEmailEmpty
        } else if !email.isValidEmail {
            emailError = L10n.Auth.validationEmailInvalid
        }
        
        if password.isEmpty {
            passwordError = L10n.Auth.validationPasswordEmpty
        } else if password.count < 6 {
            passwordError = L10n.Auth.validationPasswordMinLength
        }
        
        if confirmPassword.isEmpty {
            confirmPasswordError = L10n.Auth.validationConfirmPasswordEmpty
        } else if password != confirmPassword {
            confirmPasswordError = L10n.Auth.validationPasswordsMismatch
        }
        
        if fullNameError.isEmpty && emailError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty {
            return
        } else {
            throw RegisterValidateError(
                fullNameErrorMessage: fullNameError,
                emailErrorMessage: emailError,
                passwordErrorMessage: passwordError,
                confirmPasswordErrorMessage: confirmPasswordError
            )
        }
    }
    
    private func splitFullName(_ fullName: String) -> (firstName: String, lastName: String) {
        let parts = fullName
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ", maxSplits: 1)
            .map(String.init)
        
        let firstName = parts.first ?? ""
        let lastName = parts.count > 1 ? parts[1] : ""
        return (firstName, lastName)
    }

    func execute(fullName: String, email: String, password: String, confirmPassword: String) async throws {
        try validate(fullName: fullName, email: email, password: password, confirmPassword: confirmPassword)
        let (firstName, lastName) = splitFullName(fullName)
        try await authRepo.createUserWithEmailAndPassword(email: email, password: password, firstName: firstName, lastName: lastName)
    }
}

struct RegisterValidateError: Error {
    let fullNameErrorMessage: String
    let emailErrorMessage: String
    let passwordErrorMessage: String
    let confirmPasswordErrorMessage: String
}
