//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import SwiftUI

@MainActor
public final class OrderDetailsViewModel: ObservableObject {
    @Published public private(set) var order: Order?

    public init(orderID: String, ordersViewModel: OrdersViewModel) {
        self.order = Self.resolveOrder(orderID: orderID, from: ordersViewModel.state)
    }

    private static func resolveOrder(orderID: String, from state: OrdersViewModel.State) -> Order? {
        guard case .loaded(let orders) = state else { return nil }
        return orders.first { $0.id == orderID }
    }
}
