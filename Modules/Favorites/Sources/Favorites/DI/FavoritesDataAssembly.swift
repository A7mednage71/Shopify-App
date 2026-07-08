import Foundation
import Swinject
import Persistence
import CoreData
import Common

public final class FavoritesDataAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(FavoritesRepository.self) { _ in
            let context = PersistenceController.shared.viewContext
            let tokenStore = KeychainTokenStore()
            return FavoritesRepositoryImpl(context: context, tokenStore: tokenStore)
        }
    }
}
