import Common

public struct KeychainCustomerAccessTokenDataSource: CustomerAccessTokenDataSource, Sendable {
    private let customerAccessTokenProvider: any CustomerAccessTokenProvider

    public init(customerAccessTokenProvider: any CustomerAccessTokenProvider = KeychainCustomerAccessTokenProvider()) {
        self.customerAccessTokenProvider = customerAccessTokenProvider
    }

    public func customerAccessToken() async throws -> String {
        try customerAccessTokenProvider.customerAccessToken()
    }
}
