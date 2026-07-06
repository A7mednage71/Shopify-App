//
//  File.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import Foundation
import MarktekNetworking
import ShopifyAPI

public final class CustomerApiDataSource: CustomerApiDataSourceProtocol {
    public static let shared = CustomerApiDataSource()
    private let client = ShopifyGraphQLClient.shared
    private init() {}
    public func fetchCustomerName(customerAccessToken: String) async throws -> CustomerProfileDTO {
        let query = GetCustomerQuery(customerAccessToken: customerAccessToken)

        let data: GetCustomerQuery.Data
        do {
            data = try await client.fetch(query)
        } catch {
            throw AddressError.networkError
        }

        guard let customer = data.customer else {
            throw AddressError.unauthorized
        }

        return CustomerProfileDTO(
            firstName: customer.firstName,
            lastName: customer.lastName
        )
    }
}

