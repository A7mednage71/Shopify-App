//
//  File.swift
//  
//
//  Created by Esraa Ehab on 06/07/2026.
//

import Foundation

public protocol OrdersRepository: Sendable {
    func fetchOrders() async throws -> [Order]
}
