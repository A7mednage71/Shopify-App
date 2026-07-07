//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI
import Common
struct NoSavedAddressesView: View {
    var onAddAddress: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            iconView

            VStack(spacing: 8) {
                Text("No Saved Addresses")
                    .font(AppFonts.title3)
                    .foregroundColor(AppColors.textPrimary)

                Text("You haven't saved any addresses yet.\nAdd a new address to get started.")
                    .font(AppFonts.subheadline)
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 32)

            addButton
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }

    private var iconView: some View {
    
            Image( "no_addresses",bundle: .module).resizable() .frame(width: 200, height: 200)
                
                .foregroundColor(AppColors.primary)
        
    }

    private var addButton: some View {
        Button(action: onAddAddress) {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .bold))
                Text("Add New Address")
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


