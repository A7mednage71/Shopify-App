import Swinject

struct ProductInfoPresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductInfoViewModelFactory.self) { resolver in
            ProductInfoViewModelFactory(
                getProductInfoUseCase: resolver.resolve(GetProductInfoUseCaseProtocol.self)!
            )
        }
    }
}
