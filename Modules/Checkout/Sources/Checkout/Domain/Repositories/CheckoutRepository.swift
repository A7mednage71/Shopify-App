import Foundation

public protocol CheckoutRepository: Sendable {
    func createOrder(input: OrderCreateInput) async throws -> Order
    func getCustomerDetails() async throws -> CustomerDetails
    func validateDiscountCode(code: String) async throws -> ValidatedDiscountCode?
}
