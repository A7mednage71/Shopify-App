//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI
import Common
struct NewAddressButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.primary)
                
                Text(L10n.Address.addNew)
                    .font(AppFonts.headline)
                    .foregroundColor(AppColors.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppColors.primary.opacity(0.04))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        AppColors.primary,
                        style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round, dash: [6, 4])
                    )
            )
        }
        .buttonStyle(NewAddressPressableButtonStyle())
    }
}

fileprivate struct NewAddressPressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

//struct SwiftUIView_2_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView_2()
//    }
//}
