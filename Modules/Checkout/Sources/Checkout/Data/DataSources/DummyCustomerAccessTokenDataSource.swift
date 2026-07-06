public struct DummyCustomerAccessTokenDataSource: CustomerAccessTokenDataSource, Sendable {
    private let token: String

    public init(token: String = "648edf17ddb633d185b256f956cefaf4") {
        self.token = token
    }

    public func customerAccessToken() async throws -> String {
        token
    }
}
