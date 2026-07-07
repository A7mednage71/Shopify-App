//
//  File.swift
//  
//
//  Created by Eyad waleed on 02/07/2026.
//

import Foundation
import OSLog

public enum AuthSessionStatus: String, Equatable, Sendable {
    case authenticated
    case guest
    case unauthenticated
}

@MainActor
public final class AuthState: ObservableObject {
    @Published public private(set) var sessionStatus: AuthSessionStatus = .unauthenticated

    private let tokenStore: any CustomerTokenStore
    private let userDefaults: UserDefaults
    private let guestSessionKey = "marktek.auth.isGuest"
    private let logger = Logger(subsystem: "com.marktek.auth", category: "AuthState")

    public var isLoggedIn: Bool {
        sessionStatus == .authenticated
    }

    public var isGuest: Bool {
        sessionStatus == .guest
    }

    public var canUseProtectedFeatures: Bool {
        sessionStatus == .authenticated
    }

    public var shouldShowMainFlow: Bool {
        sessionStatus != .unauthenticated
    }

    public init(
        tokenStore: any CustomerTokenStore = KeychainTokenStore(),
        userDefaults: UserDefaults = .standard
    ) {
        self.tokenStore = tokenStore
        self.userDefaults = userDefaults
        checkExistingSession()
    }

    public func checkExistingSession() {
        if let stored = tokenStore.load(), !stored.isExpired {
            userDefaults.set(false, forKey: guestSessionKey)
            updateSessionStatus(.authenticated, reason: "checkExistingSession")
        } else if userDefaults.bool(forKey: guestSessionKey) {
            updateSessionStatus(.guest, reason: "checkExistingSession")
        } else {
            updateSessionStatus(.unauthenticated, reason: "checkExistingSession")
        }
    }

    public func markLoggedIn() {
        userDefaults.set(false, forKey: guestSessionKey)
        updateSessionStatus(.authenticated, reason: "markLoggedIn")
    }

    public func markGuest() {
        tokenStore.delete()
        userDefaults.set(true, forKey: guestSessionKey)
        updateSessionStatus(.guest, reason: "markGuest")
    }

    public func markLoggedOut() {
        tokenStore.delete()
        userDefaults.set(false, forKey: guestSessionKey)
        updateSessionStatus(.unauthenticated, reason: "markLoggedOut")
    }

    public func markNeedsLogin() {
        userDefaults.set(false, forKey: guestSessionKey)
        updateSessionStatus(.unauthenticated, reason: "markNeedsLogin")
    }

    private func updateSessionStatus(_ status: AuthSessionStatus, reason: String) {
        let previousStatus = sessionStatus
        sessionStatus = status
        logAuthStateChange(from: previousStatus, to: status, reason: reason)
    }

    private func logAuthStateChange(
        from previousStatus: AuthSessionStatus,
        to currentStatus: AuthSessionStatus,
        reason: String
    ) {
        let storedToken = tokenStore.load()
        let hasStoredCustomerToken = storedToken != nil
        let isStoredCustomerTokenExpired = storedToken?.isExpired ?? false
        let customerTokenExpiresAt = storedToken?.expiresAt ?? "none"

        logger.info(
            """
            Auth state changed reason=\(reason, privacy: .public) \
            previousStatus=\(previousStatus.rawValue, privacy: .public) \
            currentStatus=\(currentStatus.rawValue, privacy: .public) \
            isLoggedIn=\(self.isLoggedIn, privacy: .public) \
            isGuest=\(self.isGuest, privacy: .public) \
            canUseProtectedFeatures=\(self.canUseProtectedFeatures, privacy: .public) \
            hasStoredCustomerToken=\(hasStoredCustomerToken, privacy: .public) \
            isStoredCustomerTokenExpired=\(isStoredCustomerTokenExpired, privacy: .public) \
            customerTokenExpiresAt=\(customerTokenExpiresAt, privacy: .public)
            """
        )
    }
}
