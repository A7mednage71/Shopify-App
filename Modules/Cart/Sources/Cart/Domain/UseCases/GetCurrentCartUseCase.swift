struct GetCurrentCartUseCase: GetCurrentCartUseCaseProtocol, Sendable {
    private let repository: any CartRepository

    init(repository: any CartRepository) {
        self.repository = repository
    }

    func execute() async throws -> CartDetails {
        try await repository.getCurrentCart()
    }
}
