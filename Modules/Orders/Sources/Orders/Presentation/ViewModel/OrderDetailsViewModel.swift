//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import SwiftUI
import Common
import Combine

@MainActor
public final class OrderDetailsViewModel: ObservableObject {
    public enum State {
        case loading
        case loaded(Order)
        case failure(String)
    }

    @Published public private(set) var state: State = .loading

    private let orderID: String
    private let ordersViewModel: OrdersViewModel
    private let submitProductReviewUseCase: any SubmitProductReviewUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    public init(
        orderID: String,
        ordersViewModel: OrdersViewModel,
        submitProductReviewUseCase: any SubmitProductReviewUseCaseProtocol
    ) {
        self.orderID = orderID
        self.ordersViewModel = ordersViewModel
        self.submitProductReviewUseCase = submitProductReviewUseCase
        observeOrdersState()
        updateState(from: ordersViewModel.state)
    }

    public func loadOrderIfNeeded() async {
        guard case .loading = state else { return }
        await ordersViewModel.loadOrders()
    }

    public func retry() async {
        state = .loading
        await ordersViewModel.loadOrders()
    }

    public func submitReview(input: ProductReviewInput, customerName: String) async throws {
        try await submitProductReviewUseCase.execute(input: input, customerName: customerName)
    }

    private func observeOrdersState() {
        ordersViewModel.$state
            .sink { [weak self] state in
                self?.updateState(from: state)
            }
            .store(in: &cancellables)
    }

    private func updateState(from ordersState: OrdersViewModel.State) {
        switch ordersState {
        case .loading:
            state = .loading
        case .loaded(let orders):
            if let order = orders.first(where: { $0.id == orderID }) {
                state = .loaded(order)
            } else {
                state = .failure(L10n.Orders.errorOrderNotFound)
            }
        case .empty:
            state = .failure(L10n.Orders.errorOrderNotFound)
        case .failure(let message):
            state = .failure(message)
        }
    }
}
