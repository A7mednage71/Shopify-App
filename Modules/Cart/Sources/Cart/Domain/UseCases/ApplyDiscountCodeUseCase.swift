protocol ApplyDiscountCodeUseCaseProtocol: Sendable {
    func execute(input: ApplyDiscountCodesInput) async throws -> CartDetails
}

struct ApplyDiscountCodeUseCase: ApplyDiscountCodeUseCaseProtocol, Sendable {
    private let repository: any CartRepository

    init(repository: any CartRepository) {
        self.repository = repository
    }

    func execute(input: ApplyDiscountCodesInput) async throws -> CartDetails {
        try await repository.applyDiscountCodes(discountCodes: input.discountCodes)
    }
}
