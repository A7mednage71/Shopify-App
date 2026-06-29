import Swinject

enum CartAssembler {
    static func resolveAddItemToCartUseCase() -> any AddItemToCartUseCaseProtocol {
        makeAssembler().resolver.resolve(AddItemToCartUseCaseProtocol.self)!
    }

    private static func makeAssembler() -> Assembler {
        Assembler([
            CartDataAssembly(),
            CartDomainAssembly(),
        ])
    }
}
