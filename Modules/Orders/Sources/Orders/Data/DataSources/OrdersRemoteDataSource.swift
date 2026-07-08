//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import MarktekNetworking
import Common

public enum OrdersError: LocalizedError {
    case customerNotFound
    case unknown

    public var errorDescription: String? {
        switch self {
        case .customerNotFound:
            return L10n.Orders.errorCustomerNotFound
        case .unknown:
            return L10n.Orders.errorUnknown
        }
    }
}

public protocol OrdersRemoteDataSource: Sendable {
    func getOrders() async throws -> [OrderDataModel]
}

public struct ShopifyOrdersRemoteDataSource: OrdersRemoteDataSource, Sendable {
    private let customerAccessTokenDataSource: CustomerAccessTokenDataSource
    private let localizationManager: LocalizationManager

    public init(customerAccessTokenDataSource: CustomerAccessTokenDataSource, localizationManager: LocalizationManager) {
        self.customerAccessTokenDataSource = customerAccessTokenDataSource
        self.localizationManager = localizationManager
    }

    public func getOrders() async throws -> [OrderDataModel] {
        let customerAccessToken = try await customerAccessTokenDataSource.customerAccessToken()
        let language: GraphQLEnum<LanguageCode> = localizationManager.currentLanguage == .en ? .case(.en) : .case(.ar)
        let query = GetCustomerOrdersQuery(customerAccessToken: customerAccessToken, first: 20, language: .some(language))
        let data = try await ShopifyGraphQLClient.shared.fetch(query)

        guard let gqlCustomer = data.customer else {
            throw OrdersError.customerNotFound
        }

        let firstName = gqlCustomer.firstName ?? ""
        let lastName = gqlCustomer.lastName ?? ""
        let customerName = [firstName, lastName]
            .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")
        let displayName = customerName.isEmpty ? "Customer" : customerName

        return gqlCustomer.orders.edges.map { OrderDataModel(gqlOrderNode: $0.node, customerName: displayName) }
    }
}
