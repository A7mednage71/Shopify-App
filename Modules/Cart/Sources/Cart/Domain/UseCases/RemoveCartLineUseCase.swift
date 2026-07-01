protocol RemoveCartLineUseCaseProtocol: Sendable {
    func execute(lineID: String) async throws -> CartDetails
}

struct RemoveCartLineUseCase: RemoveCartLineUseCaseProtocol, Sendable {
    private let removeCartLinesUseCase: any RemoveCartLinesUseCaseProtocol
    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol

    init(
        removeCartLinesUseCase: any RemoveCartLinesUseCaseProtocol,
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    ) {
        self.removeCartLinesUseCase = removeCartLinesUseCase
        self.getCurrentCartUseCase = getCurrentCartUseCase
    }

    func execute(lineID: String) async throws -> CartDetails {
        _ = try await removeCartLinesUseCase.execute(
            input: RemoveCartLinesInput(lineIDs: [lineID])
        )

        return try await getCurrentCartUseCase.execute()
    }
}
