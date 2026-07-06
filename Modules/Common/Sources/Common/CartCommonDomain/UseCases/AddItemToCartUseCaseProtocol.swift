public protocol AddItemToCartUseCaseProtocol: Sendable {
    func execute(input: AddCartItemInput) async throws -> CartDetails
}
