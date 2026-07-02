//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import SwiftUI
import Common

@available(iOS 14.0, *)
public struct SettingsSectionView<Content: View>: View {
    let title: String
    let content: Content
    
    public init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(AppFonts.footnote.weight(.bold))
                .foregroundColor(AppColors.textSecondary)
                .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                content
            }
            .padding(.horizontal, 16)
            .background(AppColors.background)
            .cornerRadius(20)
            .shadow(color: AppColors.shadow.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }
}
