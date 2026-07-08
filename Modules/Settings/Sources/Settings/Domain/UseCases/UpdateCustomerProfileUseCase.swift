public protocol UpdateCustomerProfileUseCaseProtocol: Sendable {
    func execute(_ input: CustomerProfileUpdateInput) async throws -> CustomerProfile
}

public struct UpdateCustomerProfileUseCase: UpdateCustomerProfileUseCaseProtocol, Sendable {
    private let repository: CustomerProfileRepository

    public init(repository: CustomerProfileRepository) {
        self.repository = repository
    }

    public func execute(_ input: CustomerProfileUpdateInput) async throws -> CustomerProfile {
        try await repository.updateCustomerProfile(input)
    }
}
