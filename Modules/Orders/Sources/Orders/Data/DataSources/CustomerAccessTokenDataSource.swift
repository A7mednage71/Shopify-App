//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import Common

public protocol CustomerAccessTokenDataSource: Sendable {
    func customerAccessToken() async throws -> String
}

public struct KeychainCustomerAccessTokenDataSource: CustomerAccessTokenDataSource, Sendable {
    private let customerAccessTokenProvider: any CustomerAccessTokenProvider

    public init(customerAccessTokenProvider: any CustomerAccessTokenProvider = KeychainCustomerAccessTokenProvider()) {
        self.customerAccessTokenProvider = customerAccessTokenProvider
    }

    public func customerAccessToken() async throws -> String {
        try customerAccessTokenProvider.customerAccessToken()
    }
}
