//
//  AuthPrtocol.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
protocol AuthenticationService{
    @available(iOS 13.0.0, *)
    func createUserWithEmailAndPassword(email: String, password: String,firstName : String , lastName  : String) async throws
    func signInUsingEmailAndPassword(email : String , password : String) async throws -> CustomerDto
    }

protocol AuthenticationServiceViaPlatform{
    @available(iOS 13.0.0, *)
    func signInUsingGoogle() async throws -> (email : String , password : String) ;
    @available(iOS 13.0.0, *)
    func signInUsingApple() async throws ;
    
    func signOut() async throws;
 }
