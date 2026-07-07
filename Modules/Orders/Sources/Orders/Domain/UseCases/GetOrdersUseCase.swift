//
//  File.swift
//  
//
//  Created by Esraa Ehab on 06/07/2026.
//

import Foundation

public protocol GetOrdersUseCaseProtocol: Sendable {
    func execute() async throws -> [Order]
}

public struct GetOrdersUseCase: GetOrdersUseCaseProtocol, Sendable {
    private let repository: any OrdersRepository

    public init(repository: any OrdersRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [Order] {
        try await repository.fetchOrders()
    }
}
