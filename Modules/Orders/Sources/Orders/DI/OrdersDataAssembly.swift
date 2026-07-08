//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Swinject
import Common

public struct OrdersDataAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(CustomerAccessTokenDataSource.self) { _ in
            DummyCustomerAccessTokenDataSource()
        }

        container.register(OrdersRemoteDataSource.self) { resolver in
            ShopifyOrdersRemoteDataSource(
                customerAccessTokenDataSource: resolver.resolve(CustomerAccessTokenDataSource.self)!,
                localizationManager: LocalizationManager.shared
            )
        }

        container.register(OrdersRepository.self) { resolver in
            OrdersRepositoryImpl(
                remoteDataSource: resolver.resolve(OrdersRemoteDataSource.self)!
            )
        }
    }
}
