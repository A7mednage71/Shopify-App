import Swinject

struct AppCoordinationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainFlowViewFactory.self) { _ in
            MainFlowViewFactory()
        }
    }
}
