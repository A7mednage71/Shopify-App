//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
protocol AuthenticationProtcol{
    func createUserWithEmailAndPassword() throws;
    func signInUsingGoogle() throws;
    func signInUsingApple() throws;
    func signInUsingEmailAndpassword() throws ;
    }
