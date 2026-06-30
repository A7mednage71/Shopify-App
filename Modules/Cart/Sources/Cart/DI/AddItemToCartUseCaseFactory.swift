public enum AddItemToCartUseCaseFactory {
    public static func make() -> any AddItemToCartUseCaseProtocol {
        CartAssembler.resolveAddItemToCartUseCase()
    }
}
