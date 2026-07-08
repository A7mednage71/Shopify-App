enum ProfileFlowRoute: Hashable {
    case personalInformation
    case addresses
    case orders
    case orderDetails(orderID: String)
}
