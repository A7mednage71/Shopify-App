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
        Button(action: action) {
            Text(label)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(AppColors.textWhite)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(AppColors.primary)
                .cornerRadius(14)
                .shadow(color: AppColors.primary.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PressableButtonStyle())
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
