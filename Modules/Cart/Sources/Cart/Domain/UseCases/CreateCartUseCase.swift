protocol CreateCartUseCaseProtocol: Sendable {
    func execute(lines: [AddCartLineRequest]) async throws -> CartDetails
}

struct CreateCartUseCase: CreateCartUseCaseProtocol, Sendable {
    private let repository: any CartRepository

    init(repository: any CartRepository) {
        self.repository = repository
    }

    func execute(lines: [AddCartLineRequest]) async throws -> CartDetails {
        try await repository.createCart(lines: lines)
    }
}
