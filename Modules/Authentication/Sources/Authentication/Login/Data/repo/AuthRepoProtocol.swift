//
//  File.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import Foundation
protocol AuthInterface {
    @available(iOS 13.0.0, *)
    func signIn(email: String, password: String) async throws
}
