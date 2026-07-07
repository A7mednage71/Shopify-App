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
class FirebaseAuthenitcation : AuthenticationServiceViaPlatform{
    
    @available(iOS 13.0.0, *)
    func signInUsingGoogle() async throws -> (email: String, password: String, firstName: String, lastName: String) {
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

            let authResult = try await Auth.auth().signIn(with: credential)

            guard let email = authResult.user.email else {
                throw AuthError.unknown
            }

            let password = Self.generateShopifyPassword(for: email)
            let names = Self.splitFullName(authResult.user.displayName, fallbackEmail: email)

            return (email: email, password: password, firstName: names.firstName, lastName: names.lastName)

        } catch {
            try mapGoogleError(error)
            throw AuthError.unknown
        }
    }

    private static func generateShopifyPassword(for email: String) -> String {
        let localPart = email
            .split(separator: "@")
            .first
            .map(String.init) ?? "googleuser"
        let safeLocalPart = localPart
            .lowercased()
            .filter { $0.isLetter || $0.isNumber }
            .prefix(12)

        return "Mk1@\(safeLocalPart.isEmpty ? "googleuser" : String(safeLocalPart))"
    }

    private static func splitFullName(_ fullName: String?, fallbackEmail: String) -> (firstName: String, lastName: String) {
        let parts = (fullName ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ", maxSplits: 1)
            .map(String.init)

        let fallbackFirstName = fallbackEmail.split(separator: "@").first.map(String.init) ?? ""
        return (firstName: parts.first ?? fallbackFirstName, lastName: parts.count > 1 ? parts[1] : "")
    }

    func signInUsingApple() throws {
        
    }
    func signOut() async throws {
                
                guard Auth.auth().currentUser != nil else {
                  
                    return
                }
                
                do {
                    GIDSignIn.sharedInstance.signOut()
                    
                    try Auth.auth().signOut()
                    
                } catch {
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
        if nsError.domain == kGIDSignInErrorDomain {
            switch nsError.code {
            case -5: //
                break
            case -4:
                throw AuthError.unknown
            default:
                throw AuthError.unknown
            }
        }
        try mapFirebaseError(error)
    }
}
