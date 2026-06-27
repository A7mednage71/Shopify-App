//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
protocol AuthenticationProtcol{
    @available(iOS 13.0.0, *)
    func createUserWithEmailAndPassword() async throws;
    @available(iOS 13.0.0, *)
    func signInUsingGoogle() async throws;
    @available(iOS 13.0.0, *)
    func signInUsingApple() async throws;
    @available(iOS 13.0.0, *)
    func signInUsingEmailAndpassword(email : String , password : String) async throws ;
    }
