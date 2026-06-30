protocol UpdateCartLinesUseCaseProtocol: Sendable {
    func execute(input: UpdateCartLinesInput) async throws -> CartDetails
}

struct UpdateCartLinesUseCase: UpdateCartLinesUseCaseProtocol, Sendable {
    private let repository: any CartRepository

    init(repository: any CartRepository) {
        self.repository = repository
    }

    func execute(input: UpdateCartLinesInput) async throws -> CartDetails {
        try input.lines.forEach { line in
            try CartQuantityValidator.validate(
                requestedQuantity: line.quantity,
                availableQuantity: line.availableQuantity
            )
        }

        return try await repository.updateLines(lines: input.lines)
    }
}
