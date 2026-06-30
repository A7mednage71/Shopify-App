import Swinject

enum CartAssembler {
    
    static func resolveCreateCartUseCase() -> any CreateCartUseCaseProtocol {
        makeAssembler().resolver.resolve(CreateCartUseCaseProtocol.self)!
    }
    
    static func resolveGetCurrentCartUseCase() -> any GetCurrentCartUseCaseProtocol {
        makeAssembler().resolver.resolve(GetCurrentCartUseCaseProtocol.self)!
    }

    static func resolveAddItemToCartUseCase() -> any AddItemToCartUseCaseProtocol {
        makeAssembler().resolver.resolve(AddItemToCartUseCaseProtocol.self)!
    }

    static func resolveRemoveCartLinesUseCase() -> any RemoveCartLinesUseCaseProtocol {
        makeAssembler().resolver.resolve(RemoveCartLinesUseCaseProtocol.self)!
    }

    static func resolveUpdateCartLinesUseCase() -> any UpdateCartLinesUseCaseProtocol {
        makeAssembler().resolver.resolve(UpdateCartLinesUseCaseProtocol.self)!
    }

    static func resolveUpdateCartLineQuantityUseCase() -> any UpdateCartLineQuantityUseCaseProtocol {
        makeAssembler().resolver.resolve(UpdateCartLineQuantityUseCaseProtocol.self)!
    }

    static func resolveRemoveCartLineUseCase() -> any RemoveCartLineUseCaseProtocol {
        makeAssembler().resolver.resolve(RemoveCartLineUseCaseProtocol.self)!
    }

    private static func makeAssembler() -> Assembler {
        Assembler([
            CartDataAssembly(),
            CartDomainAssembly(),
            CartPresentationAssembly(),
        ])
    }
}
