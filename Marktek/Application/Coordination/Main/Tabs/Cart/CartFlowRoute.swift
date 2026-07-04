import Foundation

enum CartFlowRoute: Hashable {
    case shared(SharedFlowRoute)
    case checkout
    case orderConfirmation(UUID)

    var isOrderConfirmation: Bool {
        if case .orderConfirmation = self {
            return true
        }

        return false
    }
}
