import Foundation
import MarktekNetworking

public enum CheckoutError: LocalizedError {
    case userError([String])
    case unknown

    public var errorDescription: String? {
        switch self {
        case .userError(let messages):
            return messages.joined(separator: ", ")
        case .unknown:
            return "An unknown error occurred during checkout."
        }
    }
}

public protocol CheckoutRemoteDataSource: Sendable {
    func createOrder(input: OrderCreateInput) async throws -> OrderDataModel
    func getCustomerDetails() async throws -> CustomerDetailsDataModel
}

public struct ShopifyCheckoutRemoteDataSource: CheckoutRemoteDataSource, Sendable {
    private let customerAccessTokenDataSource: CustomerAccessTokenDataSource
    
    public init(customerAccessTokenDataSource: CustomerAccessTokenDataSource) {
        self.customerAccessTokenDataSource = customerAccessTokenDataSource
    }

    public func getCustomerDetails() async throws -> CustomerDetailsDataModel {
        let customerAccessToken = try await customerAccessTokenDataSource.customerAccessToken()
        let query = GetCustomerDetailsQuery(customerAccessToken: customerAccessToken)
        let data = try await ShopifyGraphQLClient.shared.fetch(query)
        
        guard let gqlCustomer = data.customer else {
            throw CheckoutError.unknown
        }
        
        return CustomerDetailsDataModel(gqlCustomer: gqlCustomer)
    }

    public func createOrder(input: OrderCreateInput) async throws -> OrderDataModel {
        let orderInput = input.toGraphQLInput()
        let mutation = CreateOrderMutation(order: orderInput, options: .none)
        let data = try await ShopifyAdminGraphQLClient.shared.perform(mutation)

        if let userErrors = data.orderCreate?.userErrors, !userErrors.isEmpty {
            let errorMessages = userErrors.map { $0.message }
            throw CheckoutError.userError(errorMessages)
        }

        guard let gqlOrder = data.orderCreate?.order else {
            throw CheckoutError.unknown
        }

        return OrderDataModel(gqlOrder: gqlOrder)
    }
}
