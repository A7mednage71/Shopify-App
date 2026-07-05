import Common

struct CreateCartUseCase: CreateCartUseCaseProtocol, Sendable {
    private let repository: any CartRepository

    init(repository: any CartRepository) {
        self.repository = repository
    }

    func execute() async throws -> CartDetails {
        try await execute(lines: [])
    }

    func execute(lines: [AddCartLineRequest]) async throws -> CartDetails {
        try await repository.createCart(lines: lines)
    }
}
