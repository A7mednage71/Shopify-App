//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation

@MainActor
public final class OrdersViewModel: ObservableObject {
    public enum State {
        case loading
        case loaded([Order])
        case empty
        case failure(String)
    }

    @Published public private(set) var state: State = .loading

    private let getOrdersUseCase: any GetOrdersUseCaseProtocol

    nonisolated public init(getOrdersUseCase: any GetOrdersUseCaseProtocol) {
        self.getOrdersUseCase = getOrdersUseCase
    }

    public func loadOrdersIfNeeded() async {
        guard case .loading = state else { return }
        await loadOrders()
    }

    public func loadOrders() async {
        state = .loading
        do {
            let orders = try await getOrdersUseCase.execute()
            state = orders.isEmpty ? .empty : .loaded(orders)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
