//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation

enum AuthError: Error {
    case invalidCredentials
    case userNotFound
    case emailAlreadyInUse
    case networkError
    case unknown
}
