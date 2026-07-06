protocol UpdateCartLineQuantityUseCaseProtocol: Sendable {
    func execute(lineID: String, quantity: Int, availableQuantity: Int?) async throws -> CartDetails
}

struct UpdateCartLineQuantityUseCase: UpdateCartLineQuantityUseCaseProtocol, Sendable {
    private let updateCartLinesUseCase: any UpdateCartLinesUseCaseProtocol
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol

    init(
        updateCartLinesUseCase: any UpdateCartLinesUseCaseProtocol,
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    ) {
        self.updateCartLinesUseCase = updateCartLinesUseCase
        self.getCurrentCartUseCase = getCurrentCartUseCase
    }

    func execute(lineID: String, quantity: Int, availableQuantity: Int?) async throws -> CartDetails {
        _ = try await updateCartLinesUseCase.execute(
            input: UpdateCartLinesInput(
                lines: [
                    UpdateCartLineRequest(
                        lineID: lineID,
                        quantity: quantity,
                        availableQuantity: availableQuantity
                    ),
                ]
            )
        )

        return try await getCurrentCartUseCase.execute()
    }
}
