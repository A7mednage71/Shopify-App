//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI
import Common

struct AddressItem: View {
    @Binding var isSelected: Bool
    var addressItem: AddressDomain
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(isSelected ? AppColors.primary.opacity(0.12) : AppColors.backgroundSecondary)
                    .frame(width: 44, height: 44)
                
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(isSelected ? AppColors.primary : AppColors.textSecondary)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                // Customer Name
                Text("\(addressItem.firstName) \(addressItem.lastName)")
                    .font(AppFonts.subheadline.weight(.bold))
                    .foregroundColor(AppColors.textPrimary)
                
                // Street Details
                Text(addressItem.address1)
                    .font(AppFonts.footnote)
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
                
                // City, Country & Zip
                let addressDetails = [
                    addressItem.city,
                    addressItem.province,
                    addressItem.country
                ].compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: ", ")
                
                Text("\(addressDetails) \(addressItem.zip)")
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.textTertiary)
                    .lineLimit(1)
                
                // Phone Number if available
                if let phone = addressItem.phone, !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "phone.fill")
                            .font(.system(size: 10))
                        Text(phone)
                            .font(AppFonts.caption)
                    }
                    .foregroundColor(AppColors.textTertiary)
                    .padding(.top, 2)
                }
            }
            .padding(.vertical, 16)
            
            Spacer()
            
            SelectionCircle(isSelected: isSelected)
        }
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppColors.background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? AppColors.primary : AppColors.border.opacity(0.6), lineWidth: isSelected ? 2 : 1)
        )
        .shadow(
            color: isSelected ? AppColors.primary.opacity(0.08) : AppColors.shadow.opacity(0.03),
            radius: isSelected ? 8 : 4,
            x: 0,
            y: isSelected ? 4 : 2
        )
    }
}

