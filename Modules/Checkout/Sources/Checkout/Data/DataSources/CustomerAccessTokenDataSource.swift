public protocol CustomerAccessTokenDataSource: Sendable {
    func customerAccessToken() async throws -> String
}
