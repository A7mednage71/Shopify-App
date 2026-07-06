//
//  File.swift
//
//
//  Created by Eyad waleed on 01/07/2026.
//
import Foundation
import Security
import Common
public struct StoredCustomerToken: Codable {
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

public enum KeychainError: Error {
    case saveFailed(OSStatus)
    case encodingFailed
}

public final class KeychainTokenStore {
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
