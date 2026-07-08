//
//  File.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import Foundation
import Common
public final class CustomerRepositoryImpl: CustomerRepository {
    private let dataSource: CustomerApiDataSourceProtocol
    private let customerAccessTokenProvider: any CustomerAccessTokenProvider

    public init(
        dataSource: CustomerApiDataSourceProtocol = CustomerApiDataSource.shared,
        customerAccessTokenProvider: any CustomerAccessTokenProvider = KeychainCustomerAccessTokenProvider()
    ) {
        self.dataSource = dataSource
        self.customerAccessTokenProvider = customerAccessTokenProvider
    }

    public func getName() async throws -> CustomerProfile {
        do {
            let accessToken = try customerAccessTokenProvider.customerAccessToken()
            let dto = try await dataSource.fetchCustomerName(customerAccessToken: accessToken)
            return dto.toDomain()
        } catch {
            throw AddressError.unauthorized
        }
    }
}
