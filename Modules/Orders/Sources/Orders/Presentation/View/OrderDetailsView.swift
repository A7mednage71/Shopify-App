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
    @Environment(\.dismiss) private var dismiss

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
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.backward")
                            .font(.headline)
                        Text("Payment")
                    }
                    .foregroundColor(AppColors.primary)
                }
            }
        }
    }

    @ViewBuilder
    private func content(for order: Order) -> some View {
        ScrollView {
            VStack(spacing: 24) {
                detailsCard(order: order)
                addressCard(order: order)
                productsCard(order: order)
                summaryCard(order: order)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Done")
                        .font(AppFonts.title3.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(AppColors.primary) 
                        .cornerRadius(12)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
            .padding(.vertical, 16)
        }
    }

    
    private func detailsCard(order: Order) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Order Details")
                .font(AppFonts.title2.bold())
                .foregroundColor(AppColors.textPrimary)
                .padding(.bottom, 4)
            
            infoRow(title: "Order", value: "#\(order.orderNumber)", isValueBold: false)
            HStack {
                Text("Payment Method")
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
            infoRow(title: "Payment Status", value: isPaid ? "Paid" : "Not Paid", isValueBold: false)
            
            infoRow(title: "Fulfillment Status", value: order.fulfillmentStatus.capitalized, isValueBold: false)
            
            infoRow(title: "Total", value: "\(order.totalPrice) \(order.currencyCode)", isValueBold: true)
        }
        .padding(16)
        .background(AppColors.background)
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
    
    private func productsCard(order: Order) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Products (\(order.lineItems.count))")
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
                Text("Delivery Address")
                    .font(AppFonts.title2.bold())
                    .foregroundColor(AppColors.textPrimary)
                
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(AppColors.primary)
                        .font(.title3)
                        .padding(.top, 2)
                    
                    Text(order.shippingAddress ?? "Tanta, Gharbia Governorate, Egypt\nStreet 15, Building 4, Floor 2")
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
            Text("Order Summary")
                .font(AppFonts.title2.bold())
                .foregroundColor(AppColors.textPrimary)
                .padding(.bottom, 4)
            
            infoRow(title: "Discount Code", value: "No discount code", isValueBold: false) // Dummy
            infoRow(title: "Subtotal", value: "\(order.totalPrice) \(order.currencyCode)", isValueBold: false)
            infoRow(title: "Shipping", value: "US$0", isValueBold: false) // Dummy
            infoRow(title: "Discount", value: "US$0", isValueBold: false) // Dummy
            
            Divider()
            
            infoRow(title: "Total", value: "\(order.totalPrice) \(order.currencyCode)", isValueBold: true)
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
}
