import Foundation

public protocol CheckoutRepository: Sendable {
    func createOrder(input: OrderCreateInput) async throws -> Order
    func getCustomerDetails(customerAccessToken: String) async throws -> CustomerDetails
}
