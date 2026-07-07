import Foundation

@MainActor
final class ProfileFlowCoordinator: ObservableObject {
    @Published var path: [ProfileFlowRoute] = []

    func showOrders() {
            path.append(.orders)
        }
    
    func showRoot() {
        path = []
    }
}
