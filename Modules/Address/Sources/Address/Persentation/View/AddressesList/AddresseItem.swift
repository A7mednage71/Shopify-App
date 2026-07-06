//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI
import Common
import SwiftUI
import Common

struct AddressItem: View {
    @Binding var isSelected: Bool
    var addressItem : AddressDomain
    var body: some View {
        HStack(spacing: 20) {
            Image("pin", bundle: .module)
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
               
                .foregroundStyle(isSelected ? AppColors.primary : AppColors.primaryShadow)
            
            VStack(alignment: .leading) {
                Text(addressItem.country)
                    .font(AppFonts.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.textPrimary)
                
                Text(addressItem.address1)
                    .font(AppFonts.subheadline)
                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255))
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
            .padding(.vertical, 20)
            
            Spacer()
            
          
            SelectionCircle(isSelected: isSelected)
        }
        .padding(.horizontal, 20)
        
       
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? AppColors.primaryVeryLight : Color.clear)
        )
        
        
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? AppColors.primary : AppColors.border, lineWidth: 1)
        )
    }
}


