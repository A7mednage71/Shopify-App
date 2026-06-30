import Swinject

public struct ProductInfoDomainAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(GetProductInfoUseCaseProtocol.self) { resolver in
            GetProductInfoUseCase(
                repository: resolver.resolve(ProductInfoRepository.self)!
            )
        }
    }
}
