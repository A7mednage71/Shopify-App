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
        // Fetch customer details using the hardcoded default token in the app
        let defaultToken = "648edf17ddb633d185b256f956cefaf4"
        return try await repository.getCustomerDetails(customerAccessToken: defaultToken)
    }
}
