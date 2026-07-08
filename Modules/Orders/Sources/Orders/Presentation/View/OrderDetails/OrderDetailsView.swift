//
//  OrderDetailsView.swift
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

public struct OrderDetailsView: View {
    @ObservedObject private var viewModel: OrderDetailsViewModel

    public init(viewModel: OrderDetailsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            AppColors.backgroundSecondary.ignoresSafeArea()

            if let order = viewModel.order {
                content(for: order)
            } else {
                ProgressView()
                    .scaleEffect(1.2)
                    .tint(AppColors.primary)
            }
        }
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func content(for order: Order) -> some View {
        let status = orderStatus(for: order)

        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                OrderDetailsHeroHeader(order: order, status: status)

                VStack(spacing: 16) {
                    OrderDetailsStatusTimeline(currentStatus: status)
                    OrderDetailsProductsSection(lineItems: order.lineItems)
                    OrderDetailsAddressCard(shippingAddress: order.shippingAddress)
                    OrderDetailsSummaryCard(order: order)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 32)
            }
        }
    }

    private func orderStatus(for order: Order) -> OrderStatus {
        switch order.fulfillmentStatus.uppercased() {
        case "FULFILLED", "DELIVERED": return .delivered
        case "UNFULFILLED", "PENDING": return .pending
        default:                        return .inProgress
        }
    }
}
