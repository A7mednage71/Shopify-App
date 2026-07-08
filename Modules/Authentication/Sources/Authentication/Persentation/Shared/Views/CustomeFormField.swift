//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI
import Common
@available(iOS 13.0.0, *)


struct FormField: View {
    var label: String
    var icon: String
    var isSecureField: Bool = false
    var isError: Bool = false
    @Binding var formFieldState: String
    @State private var isSecure: Bool = true
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isError ? AppColors.error : AppColors.textSecondary)
            
            if isSecureField && isSecure {
                SecureField(label, text: $formFieldState)
            } else {
                TextField(label, text: $formFieldState).keyboardType(.emailAddress) .autocapitalization(.none)
            }
            
            if isSecureField {
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(isError ? AppColors.error : AppColors.textSecondary)
                }
            }
        }
        .padding()
        .background(AppColors.backgroundSecondary)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isError ? AppColors.error : AppColors.border, lineWidth: 1)
        )
        .padding(.horizontal, 32)
    }
}

