import Foundation

@MainActor
final class ProfileFlowCoordinator: ObservableObject {
    @Published var path: [ProfileFlowRoute] = []

    func showOrders() {
            path.append(.orders)
        }
    
    func showOrderDetails(orderID: String) {
            path.append(.orderDetails(orderID: orderID))
        }
    
    func showRoot() {
        path = []
    }
}
