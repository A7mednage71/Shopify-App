//
//  OrderDetailsProductsSection.swift
//

import SwiftUI
import Common

struct OrderDetailsProductsSection: View {
    let lineItems: [OrderLineItem]
    let reviewedProductIDs: Set<String>
    let onReviewTap: ((OrderLineItem) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(L10n.Orders.products)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.textPrimary)

                Spacer()

                Text(L10n.Orders.itemsCount(lineItems.count))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(AppColors.textSecondary)
            }

            VStack(spacing: 10) {
                ForEach(lineItems) { item in
                    OrderDetailsLineItemRow(
                        lineItem: item,
                        isReviewed: item.productID.map { reviewedProductIDs.contains($0) } ?? false,
                        onReviewTap: onReviewTap
                    )
                }
            }
        }
    }
}
