//
//  SwiftUIView.swift
//  
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
            }
        }
        .navigationTitle(L10n.Orders.details)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func content(for order: Order) -> some View {
        ScrollView {
            VStack(spacing: 24) {
                detailsCard(order: order)
                addressCard(order: order)
                productsCard(order: order)
                summaryCard(order: order)
                
            }
            .padding(.vertical, 16)
        }
    }

    
    private func detailsCard(order: Order) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.Orders.details)
                .font(AppFonts.title2.bold())
                .foregroundColor(AppColors.textPrimary)
                .padding(.bottom, 4)
            
            infoRow(title: L10n.Orders.orderName, value: "#\(order.orderNumber)", isValueBold: false)
            HStack {
                Text(L10n.Orders.paymentMethod)
                    .font(AppFonts.callout)
                    .foregroundColor(AppColors.textSecondary)
                
                Spacer()
                
                HStack(spacing: 6) {
                    Image(systemName: order.paymentMethod.systemImageName)
                    Text(order.paymentMethod.title)
                }
                .font(AppFonts.callout.bold())
                .foregroundColor(AppColors.textPrimary)
            }
            
            let isPaid = order.financialStatus?.uppercased() == "PAID"
            infoRow(title: L10n.Orders.paymentStatus, value: isPaid ? L10n.Orders.paid : L10n.Orders.notPaid, isValueBold: false)
            
            infoRow(title: L10n.Orders.fulfillmentStatus, value: order.fulfillmentStatus.capitalized, isValueBold: false)
            
            priceInfoRow(title: L10n.Orders.total, priceInUSD: order.totalPrice.orderPriceViewValue, isValueBold: true)
        }
        .padding(16)
        .background(AppColors.background)
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
    
    private func productsCard(order: Order) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.Orders.productsTitle(order.lineItems.count))
                .font(AppFonts.title2.bold())
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, 16)
            
            ForEach(order.lineItems) { item in
                OrderDetailsLineItemRow(lineItem: item)
                    .padding(.horizontal, 16)
            }
        }
    }
    private func addressCard(order: Order) -> some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(L10n.Orders.deliveryAddress)
                    .font(AppFonts.title2.bold())
                    .foregroundColor(AppColors.textPrimary)
                
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(AppColors.primary)
                        .font(.title3)
                        .padding(.top, 2)
                    
                    Text(order.shippingAddress ?? L10n.Orders.noDeliveryAddress)
                        .font(AppFonts.callout)
                        .foregroundColor(AppColors.textSecondary)
                        .lineSpacing(4)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppColors.background)
            .cornerRadius(16)
            .padding(.horizontal, 16)
        }
    
    private func summaryCard(order: Order) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.Orders.summary)
                .font(AppFonts.title2.bold())
                .foregroundColor(AppColors.textPrimary)
                .padding(.bottom, 4)
            
            infoRow(title: L10n.Orders.discountCode, value: L10n.Orders.noDiscountCodeValue, isValueBold: false)
            priceInfoRow(title: L10n.Orders.subtotal, priceInUSD: order.totalPrice.orderPriceViewValue, isValueBold: false)
            priceInfoRow(title: L10n.Orders.shipping, priceInUSD: 0, isValueBold: false) // Dummy
            priceInfoRow(title: L10n.Orders.discount, priceInUSD: 0, isValueBold: false) // Dummy
            
            Divider()
            
            priceInfoRow(title: L10n.Orders.total, priceInUSD: order.totalPrice.orderPriceViewValue, isValueBold: true)
        }
        .padding(16)
        .background(AppColors.background)
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }

    
    private func infoRow(title: String, value: String, isValueBold: Bool) -> some View {
        HStack {
            Text(title)
                .font(AppFonts.callout)
                .foregroundColor(AppColors.textSecondary)
            
            Spacer()
            
            Text(value)
                .font(isValueBold ? AppFonts.callout.bold() : AppFonts.callout)
                .foregroundColor(AppColors.textPrimary)
        }
    }

    private func priceInfoRow(title: String, priceInUSD: Double, isValueBold: Bool) -> some View {
        HStack {
            Text(title)
                .font(AppFonts.callout)
                .foregroundColor(AppColors.textSecondary)
            
            Spacer()
            
            PriceView(
                priceInUSD: priceInUSD,
                font: isValueBold ? AppFonts.callout.bold() : AppFonts.callout,
                color: AppColors.textPrimary
            )
            .monospacedDigit()
        }
    }
}
