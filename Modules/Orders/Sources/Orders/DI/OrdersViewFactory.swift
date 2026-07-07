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
    public func makeOrdersDestinationView() -> some View {
        OrdersView(viewModel: viewModel)
    }
}
