//
//  OrderDetailsAddressCard.swift
//

import SwiftUI
import Common

struct OrderDetailsAddressCard: View {
    let shippingAddress: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Delivery Address")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.textPrimary)

            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    Circle()
                        .fill(AppColors.primary.opacity(0.1))
                        .frame(width: 40, height: 40)
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }

                Text(shippingAddress ?? "No address provided")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(AppColors.textSecondary)
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(AppColors.background)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: AppColors.shadow.opacity(0.07), radius: 8, x: 0, y: 3)
    }
}
