protocol RemoveCartLinesUseCaseProtocol: Sendable {
    func execute(input: RemoveCartLinesInput) async throws -> CartDetails
}

struct RemoveCartLinesUseCase: RemoveCartLinesUseCaseProtocol, Sendable {
    private let repository: any CartRepository

    init(repository: any CartRepository) {
        self.repository = repository
    }

    func execute(input: RemoveCartLinesInput) async throws -> CartDetails {
        try await repository.removeLines(lineIDs: input.lineIDs)
    }
}
