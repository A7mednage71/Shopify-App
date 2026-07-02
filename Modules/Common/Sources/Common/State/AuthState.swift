//
//  File.swift
//  
//
//  Created by Eyad waleed on 02/07/2026.
//

import Foundation

@MainActor
public final class AuthState: ObservableObject {
    @Published public var isLoggedIn: Bool = false

    private let tokenStore = KeychainTokenStore()

    public init() {
        checkExistingSession()
    }

    public func checkExistingSession() {
        if let stored = tokenStore.load(), !stored.isExpired {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }

    public  func markLoggedIn() {
        isLoggedIn = true
    }

    public  func markLoggedOut() {
        tokenStore.delete()
        isLoggedIn = false
    }
}
