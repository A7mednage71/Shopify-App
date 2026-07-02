//
//  File.swift
//  
//
//  Created by Eyad waleed on 27/06/2026.
//

import Foundation
import ShopifyAPI

enum AuthError: Error {
    case invalidCredentials
    case userNotFound
    case emailAlreadyInUse
    case networkError
    case unknowns
    case unknown
}

extension AuthError {
    static func from(code: GraphQLEnum<ShopifyAPI.CustomerErrorCode>?) -> AuthError {
        guard let code else { return .unknown }

        switch code {
        case .case(.unidentifiedCustomer):
            return .invalidCredentials
        case .case(.customerDisabled):
            return .userNotFound
        case .case(.taken):
            return .emailAlreadyInUse
        default:
            return .unknowns
        }
    }
}
