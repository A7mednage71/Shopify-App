//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI
import Common
struct NewAddressButton: View {
    var action : ()->Void
    var body: some View {
        Button(action: {
            action()
            
        }) {
            HStack(spacing: 10) {
                Image(systemName: "plus")
                    .foregroundColor(AppColors.primary)
                    .frame(width: 24, height: 24)
    
                Text("Add New Address")
                    .font(AppFonts.callout)
                    .foregroundColor(AppColors.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        Color(red: 225/255, green: 161/255, blue: 2/255),
                        lineWidth: 1
                    )
            )
        }


    }
}

//struct SwiftUIView_2_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView_2()
//    }
//}
