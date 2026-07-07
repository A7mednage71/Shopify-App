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
    private let onOrderTap: (String) -> Void

    public init(viewModel: OrdersViewModel, onOrderTap: @escaping (String) -> Void) {
        self.viewModel = viewModel
        self.onOrderTap = onOrderTap
    }

    public var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline) 
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image(systemName: "shippingbox.fill")
                        Text("Order History")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(AppColors.primary)
                }
            }
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
                        Button {
                            onOrderTap(order.id)
                        } label: {
                            OrderRowView(order: order)
                        }
                        .buttonStyle(.plain) 
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
