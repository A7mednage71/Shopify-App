import Common

struct KeychainCartLocalDataSource: CartLocalDataSource, Sendable {
    private let customerAccessTokenProvider: any CustomerAccessTokenProvider

    init(customerAccessTokenProvider: any CustomerAccessTokenProvider = KeychainCustomerAccessTokenProvider()) {
        self.customerAccessTokenProvider = customerAccessTokenProvider
    }

    func customerAccessToken() throws -> String {
        try customerAccessTokenProvider.customerAccessToken()
    }
}
