//
//  File.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import Foundation
@available(iOS 13.0.0, *)
protocol AuthRepoInterface {
    func signIn(email: String, password: String) async throws
    func signInByGoogle() async throws
}
