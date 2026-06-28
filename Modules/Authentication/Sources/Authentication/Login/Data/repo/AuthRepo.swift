//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
import FirebaseAuth
class AuthenticationRepositarory :AuthInterface  {
    
    var firebaseAuth : AuthenticationService
    init(firebaseAuth: AuthenticationService) {
        self.firebaseAuth = firebaseAuth
    }
    @available(iOS 13.0.0, *)
    func signIn(email: String, password: String) async throws {
        
        try await firebaseAuth.signInUsingEmailAndpassword(email: email, password: password)
        
    }
    
}

