//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
class FirebaseAuthenitcation : AuthenticationService{
    @available(iOS 13.0.0, *)
    func createUserWithEmailAndPassword(email: String, password: String) async throws {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                print("User Registered Successfully: \(authResult.user.email ?? "No Email")")
            } catch {
                print("Error creating user: \(error.localizedDescription)")
                throw error
            }
        }
    
    @available(iOS 13.0.0, *)
    func signInUsingGoogle() async throws {
         guard let clientID = FirebaseApp.app()?.options.clientID else {
             throw AuthError.unknown
         }
         
         let config = GIDConfiguration(clientID: clientID)
         GIDSignIn.sharedInstance.configuration = config
         
         guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = await windowScene.windows.first?.rootViewController else {
             throw AuthError.unknown
         }
         
         do {
             let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
             guard let idToken = result.user.idToken?.tokenString else {
                 throw AuthError.unknown
             }
             let credential = GoogleAuthProvider.credential(
                 withIDToken: idToken,
                 accessToken: result.user.accessToken.tokenString
             )
             try await Auth.auth().signIn(with: credential)
         } catch {
             try mapGoogleError(error)
         }
        
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
    private func mapGoogleError(_ error: Error) throws {
        let nsError = error as NSError
        // user cancelled
        if nsError.domain == kGIDSignInErrorDomain {
            switch nsError.code {
            case -5: // kGIDSignInErrorCodeCanceled
                break
            case -4: // kGIDSignInErrorCodeEMM
                throw AuthError.unknown
            default:
                throw AuthError.unknown
            }
        }
        try mapFirebaseError(error)
    }
}
