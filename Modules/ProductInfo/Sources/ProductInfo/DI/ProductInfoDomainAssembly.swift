import Swinject

struct ProductInfoDomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetProductInfoUseCaseProtocol.self) { resolver in
            GetProductInfoUseCase(
                repository: resolver.resolve(ProductInfoRepository.self)!
            )
        }
    }
}
