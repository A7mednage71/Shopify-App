import Swinject
import Apollo
import MarktekNetworking

public struct NetworkingAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        // Register admin client (named "adminApolloClient")
        container.register(ApolloClient.self, name: "adminApolloClient") { _ in
            ShopifyAdminGraphQLClient.shared.underlyingClient
        }.inObjectScope(.container)
    }
}
