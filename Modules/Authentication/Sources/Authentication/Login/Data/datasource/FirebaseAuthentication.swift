//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
import FirebaseAuth
import FirebaseCore
class FirebaseAuthenitcation : AuthenticationService{
    func createUserWithEmailAndPassword() throws {
        
    }
    
    func signInUsingGoogle() throws {
        
    }
    
    func signInUsingApple() throws {
        
    }
    
    @available(iOS 13.0.0, *)
    func signInUsingEmailAndpassword(email: String, password: String) async throws {
        do{
           
                 try await Auth.auth().signIn(withEmail: email, password: password)
            
        } catch {
            print(error.localizedDescription)
            try mapFirebaseError(error)
        }
    }
    
    private func mapFirebaseError(_ error: Error) throws {
        let error = error as NSError
        switch error.code {
        case AuthErrorCode.wrongPassword.rawValue:
            throw AuthError.invalidCredentials
        case AuthErrorCode.userNotFound.rawValue:
            throw AuthError.userNotFound
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            throw AuthError.emailAlreadyInUse
        case AuthErrorCode.networkError.rawValue:
            throw AuthError.networkError
        case AuthErrorCode.invalidCredential.rawValue:
            throw AuthError.invalidCredentials
        default:
            throw AuthError.unknown
        }
    }
}
