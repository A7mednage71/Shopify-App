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
    private let tokenStore: KeychainTokenStore

    public init(
        dataSource: CustomerApiDataSourceProtocol = CustomerApiDataSource.shared,
        tokenStore: KeychainTokenStore = KeychainTokenStore()
    ) {
        self.dataSource = dataSource
        self.tokenStore = tokenStore
    }

    public func getName() async throws -> CustomerProfile {
        guard let stored = tokenStore.load(), !stored.isExpired else {
            print("The error is here ")
            throw AddressError.unauthorized
        }
        let dto = try await dataSource.fetchCustomerName(customerAccessToken: stored.accessToken)
        return dto.toDomain()
    }
}
