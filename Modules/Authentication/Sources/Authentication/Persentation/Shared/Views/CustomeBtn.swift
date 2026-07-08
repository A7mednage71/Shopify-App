//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI
import Common
@available(iOS 13.0.0, *)
struct CustomBtn: View {
    var label: String
    var isLoading: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button {
            guard !isLoading else { return }
            action()
        } label: {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(label)
                        .font(.system(size: 18, weight: .bold))
                }
            }
            .foregroundColor(AppColors.textWhite)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.opacity(0.85)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .shadow(color: AppColors.primary.opacity(0.3), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 30)
        }
        .disabled(isLoading)
    }
}

