//
//  OrderDetailsHeroHeader.swift
//

import SwiftUI
import Common

struct OrderDetailsHeroHeader: View {
    let order: Order
    let status: OrderStatus

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [
                    status.color.opacity(0.18),
                    AppColors.backgroundSecondary.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(maxWidth: .infinity)

            VStack(spacing: 14) {
                Text("\(L10n.Orders.orderName) \(order.name)")
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundColor(AppColors.textPrimary)

                // Status badge
                HStack(spacing: 8) {
                    Circle()
                        .fill(status.color)
                        .frame(width: 9, height: 9)
                    Text(status.text)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(status.color)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .background(status.color.opacity(0.12))
                .clipShape(Capsule())

                // Date + total
                HStack(spacing: 16) {
                    Label(Self.dateFormatter.string(from: order.processedAt), systemImage: "calendar")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(AppColors.textSecondary)

                    Divider()
                        .frame(height: 14)

                    PriceView(
                        priceInUSD: order.totalPrice.orderPriceViewValue,
                        font: .system(size: 13, weight: .bold, design: .rounded),
                        color: AppColors.textPrimary
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
        }
        .background(AppColors.backgroundSecondary)
    }
}
