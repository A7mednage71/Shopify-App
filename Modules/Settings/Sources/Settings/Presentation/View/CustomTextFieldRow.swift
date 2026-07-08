//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 04/07/2026.
//

import SwiftUI
import Common

struct CustomTextFieldRow: View {
    var icon: String
    var title: String
    @Binding var text: String
    var placeholder: String
    var keyboardType: SettingsKeyboardKind = .default
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(AppColors.primary)
                .frame(width: 24)
            
            Text(title)
                .foregroundColor(AppColors.textSecondary)
                .frame(width: 90, alignment: .leading)
            
            TextField(placeholder, text: $text)
                .settingsKeyboardType(keyboardType)
                .foregroundColor(AppColors.textPrimary)
        }
        .padding()
    }
}
