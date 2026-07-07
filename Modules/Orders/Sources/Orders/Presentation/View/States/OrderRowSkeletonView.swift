//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Common
import SwiftUI

struct OrderRowSkeletonView: View {
    var body: some View {
        HStack(spacing: 12) {
            OrdersShimmerBlock(width: 48, height: 48, cornerRadius: 8)

            VStack(alignment: .leading, spacing: 8) {
                OrdersShimmerBlock(height: 16, cornerRadius: 7)
                    .frame(maxWidth: 140, alignment: .leading)
                OrdersShimmerBlock(height: 12, cornerRadius: 6)
                    .frame(maxWidth: 90, alignment: .leading)
                OrdersShimmerBlock(height: 18, cornerRadius: 9)
                    .frame(maxWidth: 70, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            OrdersShimmerBlock(width: 60, height: 16, cornerRadius: 6)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.background)
        )
    }
}
