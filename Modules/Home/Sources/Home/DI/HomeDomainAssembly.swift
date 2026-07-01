import Swinject

struct HomeDomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetCollectionsUseCaseProtocol.self) { resolver in
            GetCollectionsUseCase(
                repository: resolver.resolve(HomeRepository.self)!
            )
        }
    }
}
