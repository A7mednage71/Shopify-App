import Foundation

@MainActor
final class FavoritesFlowCoordinator: ObservableObject {
    @Published var path: [FavoritesFlowRoute] = []
}
