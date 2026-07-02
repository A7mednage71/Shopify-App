public protocol GetCurrentCartUseCaseProtocol: Sendable {
    func execute() async throws -> CartDetails
}
