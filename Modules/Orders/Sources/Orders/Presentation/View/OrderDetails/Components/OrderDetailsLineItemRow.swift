//
//  OrderDetailsLineItemRow.swift
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

struct OrderDetailsLineItemRow: View {
    let lineItem: OrderLineItem

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            // Thumbnail with quantity badge
            ZStack(alignment: .bottomTrailing) {
                thumbnail

                if lineItem.quantity > 1 {
                    Text("×\(lineItem.quantity)")
                        .font(.system(size: 10, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(AppColors.primary)
                        .clipShape(Capsule())
                        .offset(x: 4, y: 4)
                }
            }

            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text(lineItem.title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.textPrimary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Qty: \(lineItem.quantity)")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(AppColors.textTertiary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Price
            PriceView(
                priceInUSD: lineItem.price.orderPriceViewValue,
                font: .system(size: 15, weight: .bold, design: .rounded),
                color: AppColors.textPrimary
            )
            .monospacedDigit()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(AppColors.background)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: AppColors.shadow.opacity(0.07), radius: 6, x: 0, y: 2)
    }

    private var thumbnail: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AppColors.backgroundSecondary)
                .frame(width: 72, height: 72)

            if let urlString = lineItem.imageURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(AppColors.textTertiary)
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            } else {
                Image(systemName: "shippingbox")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(AppColors.textTertiary)
            }
        }
    }
}
