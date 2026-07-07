//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//



import Common
import SwiftUI
@available(iOS 13.0.0, *)
struct CustomBtn: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(AppColors.textWhite)
         
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(AppColors.primary)
                .cornerRadius(10).padding(.horizontal, 30)
        }
    }
}
