public protocol CreateCartUseCaseProtocol: Sendable {
    func execute() async throws -> CartDetails
}
