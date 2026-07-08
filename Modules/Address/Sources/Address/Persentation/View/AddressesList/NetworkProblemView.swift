//
//  SwiftUIView.swift
//  
//
//  Created by Eyad waleed on 06/07/2026.
//

import SwiftUI
import Common
struct NetworkProblemView : View {

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            iconView

            VStack(spacing: 8) {
                Text(L10n.Address.noSaved)
                    .font(AppFonts.title3)
                    .foregroundColor(AppColors.textPrimary)

                Text(L10n.Address.noSavedDesc)
                    .font(AppFonts.subheadline)
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 32)

            addButton

            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }

    private var iconView: some View {
        ZStack {
            Circle()
                .fill(AppColors.primaryLight.opacity(0.15))
                .frame(width: 100, height: 100)

            Image(systemName: "wifi.slash")
                .font(.system(size: 36, weight: .regular))
                .foregroundColor(AppColors.primary)

        }
    }

    private var addButton: some View {
        Button(action: {}) {
            HStack(spacing: 8) {
        
                Text(L10n.Address.retry)
                    .font(.buttonPrimary)
            }
            .foregroundColor(AppColors.textWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppColors.primary)
            )
        }
        .padding(.horizontal, 24)
    }
}
