//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation

public struct OrdersRepositoryImpl: OrdersRepository, Sendable {
    private let remoteDataSource: OrdersRemoteDataSource

    public init(remoteDataSource: OrdersRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func fetchOrders() async throws -> [Order] {
        let dataModels = try await remoteDataSource.getOrders()
        return dataModels.map { $0.toDomain() }
    }
}
