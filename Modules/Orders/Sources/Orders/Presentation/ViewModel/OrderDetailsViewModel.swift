//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import SwiftUI
import Common

@MainActor
public final class OrderDetailsViewModel: ObservableObject {
    @Published public private(set) var order: Order?
    private let submitProductReviewUseCase: any SubmitProductReviewUseCaseProtocol

    public init(
        orderID: String,
        ordersViewModel: OrdersViewModel,
        submitProductReviewUseCase: any SubmitProductReviewUseCaseProtocol
    ) {
        self.submitProductReviewUseCase = submitProductReviewUseCase
        self.order = Self.resolveOrder(orderID: orderID, from: ordersViewModel.state)
    }

    public func submitReview(input: ProductReviewInput, customerName: String) async throws {
        try await submitProductReviewUseCase.execute(input: input, customerName: customerName)
    }

    private static func resolveOrder(orderID: String, from state: OrdersViewModel.State) -> Order? {
        guard case .loaded(let orders) = state else { return nil }
        return orders.first { $0.id == orderID }
    }
}
