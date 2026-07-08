public protocol GetCustomerProfileUseCaseProtocol: Sendable {
    func execute() async throws -> CustomerProfile
}

public struct GetCustomerProfileUseCase: GetCustomerProfileUseCaseProtocol, Sendable {
    private let repository: CustomerProfileRepository

    public init(repository: CustomerProfileRepository) {
        self.repository = repository
    }

    public func execute() async throws -> CustomerProfile {
        try await repository.getCustomerProfile()
    }
}
