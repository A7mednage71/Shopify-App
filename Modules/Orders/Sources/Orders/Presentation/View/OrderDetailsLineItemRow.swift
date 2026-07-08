//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

struct OrderDetailsLineItemRow: View {
    let lineItem: OrderLineItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            thumbnail

            VStack(alignment: .leading, spacing: 6) {
                Text(lineItem.title.uppercased())
                    .font(AppFonts.caption.bold())
                    .foregroundColor(AppColors.textPrimary)
                    .lineLimit(2)
                
                Text(L10n.Orders.colorDefault)
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.textSecondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: 10))
                    Text(L10n.Orders.review)
                        .font(AppFonts.caption)
                        .foregroundColor(.orange)
                }
            }

            Spacer()

            PriceView(
                priceInUSD: lineItem.price.orderPriceViewValue,
                font: AppFonts.callout.bold(),
                color: AppColors.textPrimary
            )
            .monospacedDigit()
        }
        .padding(.vertical, 4)
    }

    private var thumbnail: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.backgroundSecondary)
                .frame(width: 64, height: 64)

            if let urlString = lineItem.imageURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image(systemName: "shippingbox")
                    .foregroundColor(AppColors.textTertiary)
            }
        }
    }
}
