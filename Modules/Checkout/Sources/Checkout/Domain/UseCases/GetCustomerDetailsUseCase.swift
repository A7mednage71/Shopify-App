import Foundation

public protocol GetCustomerDetailsUseCaseProtocol: Sendable {
    func execute() async throws -> CustomerDetails
}

public struct GetCustomerDetailsUseCase: GetCustomerDetailsUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository

    public init(repository: CheckoutRepository) {
        self.repository = repository
    }

    public func execute() async throws -> CustomerDetails {
        try await repository.getCustomerDetails()
    }
}
