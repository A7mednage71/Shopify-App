import Foundation

@MainActor
final class ProfileFlowCoordinator: ObservableObject {
    @Published var path: [ProfileFlowRoute] = []
}
