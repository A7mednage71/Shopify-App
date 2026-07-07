//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import MarktekNetworking

public enum OrdersError: LocalizedError {
    case customerNotFound
    case unknown

    public var errorDescription: String? {
        switch self {
        case .customerNotFound:
            return "We couldn't find your account to load your orders."
        case .unknown:
            return "Something went wrong while loading your orders."
        }
    }
}

public protocol OrdersRemoteDataSource: Sendable {
    func getOrders() async throws -> [OrderDataModel]
}

public struct ShopifyOrdersRemoteDataSource: OrdersRemoteDataSource, Sendable {
    private let customerAccessTokenDataSource: CustomerAccessTokenDataSource

    public init(customerAccessTokenDataSource: CustomerAccessTokenDataSource) {
        self.customerAccessTokenDataSource = customerAccessTokenDataSource
    }

    public func getOrders() async throws -> [OrderDataModel] {
        let customerAccessToken = try await customerAccessTokenDataSource.customerAccessToken()
        let query = GetCustomerOrdersQuery(customerAccessToken: customerAccessToken, first: 20)
        let data = try await ShopifyGraphQLClient.shared.fetch(query)

        guard let gqlCustomer = data.customer else {
            throw OrdersError.customerNotFound
        }

        return gqlCustomer.orders.edges.map { OrderDataModel(gqlOrderNode: $0.node) }
    }
}
