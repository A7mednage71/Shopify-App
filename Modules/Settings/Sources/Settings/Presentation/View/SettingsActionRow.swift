//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import SwiftUI
import Common

@available(iOS 14.0, *)
public struct SettingsActionRow: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    var action: () -> Void
    
    public init(icon: String, title: String, subtitle: String? = nil, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle().fill(AppColors.primary.opacity(0.1)).frame(width: 36, height: 36)
                    Image(systemName: icon).foregroundColor(AppColors.primary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(AppFonts.callout)
                        .foregroundColor(AppColors.textPrimary)
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(AppFonts.caption)
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .flipsForRightToLeftLayoutDirection(true)
                    .foregroundColor(AppColors.border)
            }
            .padding(.vertical, 12)
        }
    }
}
