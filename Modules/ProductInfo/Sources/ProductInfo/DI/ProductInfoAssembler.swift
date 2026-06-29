import Swinject

enum ProductInfoAssembler {
    static func resolveViewModelFactory() -> ProductInfoViewModelFactory {
        makeAssembler().resolver.resolve(ProductInfoViewModelFactory.self)!
    }

    static func resolveGetProductInfoUseCase() -> any GetProductInfoUseCaseProtocol {
        makeAssembler().resolver.resolve(GetProductInfoUseCaseProtocol.self)!
    }

    private static func makeAssembler() -> Assembler {
        Assembler([
            ProductInfoDataAssembly(),
            ProductInfoDomainAssembly(),
            ProductInfoPresentationAssembly(),
        ])
    }
}
