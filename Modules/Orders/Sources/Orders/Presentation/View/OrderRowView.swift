//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

struct OrderRowView: View {
    let order: Order

    var body: some View {
        HStack(spacing: 12) {
            thumbnail

            VStack(alignment: .leading, spacing: 4) {
                Text(order.name)
                    .font(AppFonts.callout)
                    .foregroundColor(AppColors.textPrimary)

                Text(order.processedAt, style: .date)
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.textSecondary)

                statusBadge
            }

            Spacer()

            Text("\(order.totalPrice) \(order.currencyCode)")
                .font(AppFonts.callout)
                .foregroundColor(AppColors.textPrimary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.background)
        )
    }

    private var thumbnail: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.backgroundSecondary)
                .frame(width: 48, height: 48)

            if let urlString = order.lineItems.first?.imageURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image(systemName: "shippingbox")
                    .foregroundColor(AppColors.textTertiary)
            }
        }
    }

    private var statusBadge: some View {
        Text(order.fulfillmentStatus.capitalized)
            .font(AppFonts.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                Capsule().fill(AppColors.primary.opacity(0.12))
            )
            .foregroundColor(AppColors.primary)
    }
}
