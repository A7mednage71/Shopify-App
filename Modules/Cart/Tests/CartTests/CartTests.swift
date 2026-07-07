import XCTest
import Common
@testable import Cart

final class CartTests: XCTestCase {
    func testKeychainCartLocalDataSourceReturnsProviderToken() throws {
        let dataSource = KeychainCartLocalDataSource(
            customerAccessTokenProvider: CustomerAccessTokenProviderMock(token: "cart-token")
        )

        XCTAssertEqual(try dataSource.customerAccessToken(), "cart-token")
    }

    func testKeychainCartLocalDataSourceThrowsProviderError() {
        let dataSource = KeychainCartLocalDataSource(
            customerAccessTokenProvider: CustomerAccessTokenProviderMock(error: .expired)
        )

        XCTAssertThrowsError(try dataSource.customerAccessToken()) { error in
            XCTAssertEqual(error as? CustomerAccessTokenError, .expired)
        }
    }
}

private struct CustomerAccessTokenProviderMock: CustomerAccessTokenProvider {
    private let token: String?
    private let error: CustomerAccessTokenError?

    init(token: String) {
        self.token = token
        error = nil
    }

    init(error: CustomerAccessTokenError) {
        token = nil
        self.error = error
    }

    func customerAccessToken() throws -> String {
        if let error {
            throw error
        }

        return token ?? ""
    }
}
