//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
import FirebaseAuth
import FirebaseCore
class FirebaseAuthenitcation : AuthenticationProtcol{
    
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
    
    func signInUsingGoogle() throws {
        
    }
    
    func signInUsingApple() throws {
        
    }
    
    @available(iOS 13.0.0, *)
    func signInUsingEmailAndpassword(email: String, password: String) async throws {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        print(authResult.user.email ?? "There is no value returned ")
    }
    
    
}
