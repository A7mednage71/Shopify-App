//
//  File.swift
//
//
//  Created by Eyad waleed on 01/07/2026.
//
import Foundation
import Security

public struct StoredCustomerToken: Codable, Equatable, Sendable {
    public let accessToken: String
    public let expiresAt: String

    public init(accessToken: String, expiresAt: String) {
        self.accessToken = accessToken
        self.expiresAt = expiresAt
    }

    public var isExpired: Bool {
        guard let date = parseShopifyDate(expiresAt) else {
       
            return true
        }
        return date <= Date()
    }

    private func parseShopifyDate(_ string: String) -> Date? {
        let withFractional = ISO8601DateFormatter()
        withFractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = withFractional.date(from: string) {
            return date
        }
        let standard = ISO8601DateFormatter()
        return standard.date(from: string)
    }
}

public enum KeychainError: Error, Sendable {
    case saveFailed(OSStatus)
    case encodingFailed
}

public enum CustomerAccessTokenError: LocalizedError, Equatable, Sendable {
    case missing
    case expired

    public var errorDescription: String? {
        switch self {
        case .missing:
            return "No customer access token is saved."
        case .expired:
            return "The saved customer access token has expired."
        }
    }
}

public protocol CustomerTokenStore: Sendable {
    func save(_ token: StoredCustomerToken) throws
    func load() -> StoredCustomerToken?
    func delete()
}

public protocol CustomerAccessTokenProvider: Sendable {
    func customerAccessToken() throws -> String
}

public final class KeychainTokenStore: CustomerTokenStore, @unchecked Sendable {
    private let service = "com.yourapp.customerToken"
    private let account = "shopifyCustomer"

    public init() {}

    public func save(_ token: StoredCustomerToken) throws {
        let data: Data
        do {
            data = try JSONEncoder().encode(token)
        } catch {
            throw KeychainError.encodingFailed
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)

        var attributes = query
        attributes[kSecValueData as String] = data

        let status = SecItemAdd(attributes as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.saveFailed(status)
        }
    }

    public func load() -> StoredCustomerToken? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let data = result as? Data else {
            return nil
        }

        return try? JSONDecoder().decode(StoredCustomerToken.self, from: data)
    }

    public func delete() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}

public struct KeychainCustomerAccessTokenProvider: CustomerAccessTokenProvider, Sendable {
    private let tokenStore: any CustomerTokenStore

    public init(tokenStore: any CustomerTokenStore = KeychainTokenStore()) {
        self.tokenStore = tokenStore
    }

    public func customerAccessToken() throws -> String {
        guard let stored = tokenStore.load() else {
            throw CustomerAccessTokenError.missing
        }

        guard !stored.isExpired else {
            throw CustomerAccessTokenError.expired
        }

        return stored.accessToken
    }
}
