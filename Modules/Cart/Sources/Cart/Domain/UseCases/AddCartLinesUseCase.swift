protocol AddCartLinesUseCaseProtocol: Sendable {
    func execute(lines: [AddCartLineRequest]) async throws -> CartDetails
}

struct AddCartLinesUseCase: AddCartLinesUseCaseProtocol, Sendable {
    private let repository: any CartRepository

    init(repository: any CartRepository) {
        self.repository = repository
    }

    func execute(lines: [AddCartLineRequest]) async throws -> CartDetails {
        try lines.forEach { line in
            try CartQuantityValidator.validate(
                requestedQuantity: line.quantity,
                availableQuantity: line.availableQuantity
            )
        }

        return try await repository.addLines(lines: lines)
    }
}
