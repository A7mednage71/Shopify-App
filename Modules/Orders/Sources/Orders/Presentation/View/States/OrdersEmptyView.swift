//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

struct OrdersEmptyView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("no_orders",bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .font(.system(size: 48))
                .foregroundColor(AppColors.textTertiary)

            Text(L10n.Orders.noOrders)
                .font(AppFonts.title3)
                .foregroundColor(AppColors.textPrimary)

            Text(L10n.Orders.noOrdersDesc)
                .font(AppFonts.callout)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.backgroundSecondary.ignoresSafeArea())
    }
}
