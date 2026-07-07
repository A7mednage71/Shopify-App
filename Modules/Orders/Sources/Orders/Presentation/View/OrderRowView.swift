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

    private var isPaid: Bool {
        order.financialStatus?.uppercased() == "PAID"
    }
    
    private var badgeColor: Color {
        isPaid ? Color.green : AppColors.primary
    }
    
    private var statusText: String {
        isPaid ? "Paid" : "Not Paid"
    }

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
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(badgeColor.opacity(0.65))
                        .frame(width: 5)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
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
        Text(statusText)
            .font(AppFonts.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                Capsule().fill(badgeColor.opacity(0.12))
            )
            .foregroundColor(badgeColor)
    }
}
