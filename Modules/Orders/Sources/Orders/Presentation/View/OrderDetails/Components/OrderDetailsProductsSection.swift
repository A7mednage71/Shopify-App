//
//  OrderDetailsProductsSection.swift
//

import SwiftUI
import Common

struct OrderDetailsProductsSection: View {
    let lineItems: [OrderLineItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Products")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.textPrimary)

                Spacer()

                Text("\(lineItems.count) item\(lineItems.count == 1 ? "" : "s")")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(AppColors.textSecondary)
            }

            VStack(spacing: 10) {
                ForEach(lineItems) { item in
                    OrderDetailsLineItemRow(lineItem: item)
                }
            }
        }
    }
}
