protocol CartLocalDataSource: Sendable {
    func customerAccessToken() throws -> String
}
