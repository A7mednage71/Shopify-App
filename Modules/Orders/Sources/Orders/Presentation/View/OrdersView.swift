//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

public struct OrdersView: View {
    @ObservedObject private var viewModel: OrdersViewModel

    public init(viewModel: OrdersViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        content
            .navigationTitle("Order History")
            .task {
                await viewModel.loadOrders()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(0..<5, id: \.self) { _ in
                        OrderRowSkeletonView()
                    }
                }
                .padding(16)
            }
            .allowsHitTesting(false)

        case .empty:
            OrdersEmptyView()

        case .failure(let message):
            VStack(spacing: 12) {
                Text(message)
                    .font(AppFonts.callout)
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)

                Button("Try Again") {
                    Task { await viewModel.loadOrders() }
                }
                .font(AppFonts.callout)
                .foregroundColor(AppColors.primary)
            }
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let orders):
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(orders) { order in
                        OrderRowView(order: order)
                    }
                }
                .padding(16)
            }
            .refreshable {
                await viewModel.loadOrders()
            }
        }
    }
}
