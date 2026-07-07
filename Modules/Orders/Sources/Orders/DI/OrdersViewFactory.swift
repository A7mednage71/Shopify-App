//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI

public struct OrdersViewFactory {
    private let viewModel: OrdersViewModel

    public init(viewModel: OrdersViewModel) {
        self.viewModel = viewModel
    }

    @MainActor
    public func makeOrdersDestinationView(onOrderTap: @escaping (String) -> Void) -> some View {
        OrdersView(viewModel: viewModel, onOrderTap: onOrderTap)
    }
    
    @MainActor
    public func makeOrderDetailsView(orderID: String) -> some View {
        OrderDetailsView(viewModel: OrderDetailsViewModel(orderID: orderID, ordersViewModel: viewModel))
    }
}
