import Swinject

enum HomeAssembler {
    static func resolveGetCollectionsUseCase() -> any GetCollectionsUseCaseProtocol {
        makeAssembler().resolver.resolve(GetCollectionsUseCaseProtocol.self)!
    }

    static func resolveSearchProductsUseCase() -> any SearchProductsUseCaseProtocol {
        makeAssembler().resolver.resolve(SearchProductsUseCaseProtocol.self)!
    }

    private static func makeAssembler() -> Assembler {
        Assembler([
            HomeDataAssembly(),
            HomeDomainAssembly(),
            HomePresentationAssembly(),
        ])
    }
}

