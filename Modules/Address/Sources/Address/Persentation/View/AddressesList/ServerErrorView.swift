//
//  SwiftUIView.swift
//  
//
//  Created by Eyad waleed on 06/07/2026.
//


import SwiftUI
import Common
struct ServerErrorView: View {

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            iconView

            VStack(spacing: 8) {
                Text(L10n.Address.serverError)
                    .font(AppFonts.title3)
                    .foregroundColor(AppColors.textPrimary)

                Text(L10n.Address.serverErrorDesc)
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
        

            Image(systemName: "xmark.app")
                .font(.system(size: 36, weight: .regular))
                .foregroundColor(AppColors.primary)

    
        }
    }

    private var addButton: some View {
        Button(action: {}) {
            HStack(spacing: 8) {
          
                Text(L10n.Address.tryAgain)
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


