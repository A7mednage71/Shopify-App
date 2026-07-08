//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

public struct OrdersViewFactory {
    private let viewModel: OrdersViewModel
    private let submitProductReviewUseCase: any SubmitProductReviewUseCaseProtocol

    public init(
        viewModel: OrdersViewModel,
        submitProductReviewUseCase: any SubmitProductReviewUseCaseProtocol
    ) {
        self.viewModel = viewModel
        self.submitProductReviewUseCase = submitProductReviewUseCase
    }

    @MainActor
    public func makeOrdersDestinationView(onOrderTap: @escaping (String) -> Void) -> some View {
        OrdersView(viewModel: viewModel, onOrderTap: onOrderTap)
    }
    
    @MainActor
    public func makeOrderDetailsView(orderID: String) -> some View {
        OrderDetailsView(
            viewModel: OrderDetailsViewModel(
                orderID: orderID,
                ordersViewModel: viewModel,
                submitProductReviewUseCase: submitProductReviewUseCase
            )
        )
    }
}
