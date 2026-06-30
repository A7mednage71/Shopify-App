public protocol AddItemToCartUseCaseProtocol: Sendable {
    func execute(input: AddCartItemInput) async throws -> CartDetails
}

public struct AddItemToCartUseCase: AddItemToCartUseCaseProtocol, Sendable {
    private let addCartLinesUseCase: any AddCartLinesUseCaseProtocol

    init(addCartLinesUseCase: any AddCartLinesUseCaseProtocol) {
        self.addCartLinesUseCase = addCartLinesUseCase
    }

    public func execute(input: AddCartItemInput) async throws -> CartDetails {
        return try await addCartLinesUseCase.execute(
            lines: [
                AddCartLineRequest(
                    merchandiseID: input.variantID,
                    quantity: input.quantity,
                    availableQuantity: input.availableQuantity
                ),
            ]
        )
    }
}
