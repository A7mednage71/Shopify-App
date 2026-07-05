import Foundation

public protocol CreateOrderUseCaseProtocol: Sendable {
    func execute(input: OrderCreateInput) async throws -> Order
}

public struct CreateOrderUseCase: CreateOrderUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository

    public init(repository: CheckoutRepository) {
        self.repository = repository
    }

    public func execute(input: OrderCreateInput) async throws -> Order {
        return try await repository.createOrder(input: input)
    }
}
