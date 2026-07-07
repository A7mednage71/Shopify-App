//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation

public protocol CustomerAccessTokenDataSource: Sendable {
    func customerAccessToken() async throws -> String
}

public struct DummyCustomerAccessTokenDataSource: CustomerAccessTokenDataSource, Sendable {
    private let token: String

    public init(token: String = "648edf17ddb633d185b256f956cefaf4") {
        self.token = token
    }

    public func customerAccessToken() async throws -> String {
        token
    }
}
