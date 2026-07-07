import XCTest
@testable import Common

final class CommonTests: XCTestCase {
    func testAccessTokenProviderReturnsStoredToken() throws {
        let store = CustomerTokenStoreMock(token: validToken())
        let provider = KeychainCustomerAccessTokenProvider(tokenStore: store)

        XCTAssertEqual(try provider.customerAccessToken(), "token-1")
    }

    func testAccessTokenProviderThrowsForMissingToken() {
        let provider = KeychainCustomerAccessTokenProvider(tokenStore: CustomerTokenStoreMock())

        XCTAssertThrowsError(try provider.customerAccessToken()) { error in
            XCTAssertEqual(error as? CustomerAccessTokenError, .missing)
        }
    }

    func testAccessTokenProviderThrowsForExpiredToken() {
        let provider = KeychainCustomerAccessTokenProvider(
            tokenStore: CustomerTokenStoreMock(token: expiredToken())
        )

        XCTAssertThrowsError(try provider.customerAccessToken()) { error in
            XCTAssertEqual(error as? CustomerAccessTokenError, .expired)
        }
    }

    @MainActor
    func testAuthStateStartsAuthenticatedWithValidToken() {
        let authState = makeAuthState(token: validToken())

        XCTAssertEqual(authState.sessionStatus, .authenticated)
        XCTAssertTrue(authState.isLoggedIn)
        XCTAssertTrue(authState.canUseProtectedFeatures)
    }

    @MainActor
    func testAuthStateStartsAsGuestWhenGuestWasPersisted() {
        let defaults = makeDefaults()
        defaults.set(true, forKey: "marktek.auth.isGuest")

        let authState = makeAuthState(token: nil, userDefaults: defaults)

        XCTAssertEqual(authState.sessionStatus, .guest)
        XCTAssertTrue(authState.isGuest)
        XCTAssertFalse(authState.canUseProtectedFeatures)
    }

    @MainActor
    func testAuthStateStartsUnauthenticatedWithoutTokenOrGuestSession() {
        let authState = makeAuthState(token: nil)

        XCTAssertEqual(authState.sessionStatus, .unauthenticated)
        XCTAssertFalse(authState.shouldShowMainFlow)
    }

    @MainActor
    func testMarkGuestPersistsGuestSessionAcrossInstances() {
        let defaults = makeDefaults()
        let store = CustomerTokenStoreMock()
        let authState = AuthState(tokenStore: store, userDefaults: defaults)

        authState.markGuest()
        let relaunched = AuthState(tokenStore: CustomerTokenStoreMock(), userDefaults: defaults)

        XCTAssertEqual(authState.sessionStatus, .guest)
        XCTAssertEqual(relaunched.sessionStatus, .guest)
        XCTAssertTrue(relaunched.shouldShowMainFlow)
    }

    @MainActor
    func testMarkLoggedInClearsGuestSession() {
        let defaults = makeDefaults()
        defaults.set(true, forKey: "marktek.auth.isGuest")
        let authState = AuthState(tokenStore: CustomerTokenStoreMock(), userDefaults: defaults)

        authState.markLoggedIn()
        let relaunched = AuthState(tokenStore: CustomerTokenStoreMock(), userDefaults: defaults)

        XCTAssertEqual(authState.sessionStatus, .authenticated)
        XCTAssertEqual(relaunched.sessionStatus, .unauthenticated)
    }

    @MainActor
    private func makeAuthState(
        token: StoredCustomerToken?,
        userDefaults: UserDefaults? = nil
    ) -> AuthState {
        AuthState(
            tokenStore: CustomerTokenStoreMock(token: token),
            userDefaults: userDefaults ?? makeDefaults()
        )
    }

    private func makeDefaults() -> UserDefaults {
        let suiteName = "CommonTests-\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }

    private func validToken() -> StoredCustomerToken {
        StoredCustomerToken(
            accessToken: "token-1",
            expiresAt: "2999-01-01T00:00:00Z"
        )
    }

    private func expiredToken() -> StoredCustomerToken {
        StoredCustomerToken(
            accessToken: "token-1",
            expiresAt: "2000-01-01T00:00:00Z"
        )
    }
}

private final class CustomerTokenStoreMock: CustomerTokenStore, @unchecked Sendable {
    private var token: StoredCustomerToken?

    init(token: StoredCustomerToken? = nil) {
        self.token = token
    }

    func save(_ token: StoredCustomerToken) throws {
        self.token = token
    }

    func load() -> StoredCustomerToken? {
        token
    }

    func delete() {
        token = nil
    }
}
