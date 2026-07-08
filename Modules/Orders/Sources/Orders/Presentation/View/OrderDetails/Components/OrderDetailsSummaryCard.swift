//
//  OrderDetailsSummaryCard.swift
//

import SwiftUI
import Common

struct OrderDetailsSummaryCard: View {
    let order: Order

    private var isPaid: Bool {
        order.financialStatus?.uppercased() == "PAID"
    }

    private static let paidColor   = Color(red: 39/255,  green: 174/255, blue: 96/255)
    private static let pendingColor = Color(red: 254/255, green: 195/255, blue: 57/255)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Order Summary")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.textPrimary)
                .padding(.bottom, 14)

            // Payment method
            summaryRow(
                title: "Payment",
                trailing: AnyView(
                    HStack(spacing: 6) {
                        Image(systemName: order.paymentMethod.systemImageName)
                            .font(.system(size: 13, weight: .semibold))
                        Text(order.paymentMethod.title)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(AppColors.textPrimary)
                )
            )

            // Payment status badge
            summaryRow(
                title: "Payment Status",
                trailing: AnyView(
                    Text(isPaid ? "Paid" : "Pending")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(isPaid ? Self.paidColor : Self.pendingColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background((isPaid ? Self.paidColor : Self.pendingColor).opacity(0.12))
                        .clipShape(Capsule())
                )
            )

            summaryPriceRow(title: "Subtotal", price: order.totalPrice.orderPriceViewValue, isBold: false)
            summaryPriceRow(title: "Shipping", price: 0, isBold: false)
            summaryPriceRow(title: "Discount", price: 0, isBold: false)

            Rectangle()
                .fill(AppColors.border)
                .frame(height: 1)
                .padding(.vertical, 12)

            HStack {
                Text("Total")
                    .font(.system(size: 17, weight: .heavy, design: .rounded))
                    .foregroundColor(AppColors.textPrimary)
                Spacer()
                PriceView(
                    priceInUSD: order.totalPrice.orderPriceViewValue,
                    font: .system(size: 20, weight: .heavy, design: .rounded),
                    color: AppColors.primary
                )
                .monospacedDigit()
            }
        }
        .padding(16)
        .background(AppColors.background)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: AppColors.shadow.opacity(0.07), radius: 8, x: 0, y: 3)
    }

    // MARK: - Row Helpers

    private func summaryRow(title: String, trailing: AnyView) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(AppColors.textSecondary)
            Spacer()
            trailing
        }
        .padding(.bottom, 12)
    }

    private func summaryPriceRow(title: String, price: Double, isBold: Bool) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(AppColors.textSecondary)
            Spacer()
            PriceView(
                priceInUSD: price,
                font: isBold
                    ? .system(size: 15, weight: .bold, design: .rounded)
                    : .system(size: 14, weight: .semibold, design: .rounded),
                color: AppColors.textPrimary
            )
            .monospacedDigit()
        }
        .padding(.bottom, 10)
    }
}
