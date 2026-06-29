protocol CartLocalDataSource: Sendable {
    var customerAccessToken: String { get }
    var testCartID: String { get }
}
