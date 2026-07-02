//
//  SwiftUIView 2.swift
//
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI
import Common

struct CutomeCircularBtn: View {
    var image: String
    var label: String = ""
    var action: () -> Void

    @available(iOS 13.0.0, *)
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 6) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(12)
                   

                if !label.isEmpty {
                    Text(label)
                        .font(.buttonSmall)
                        .foregroundColor(AppColors.textPrimary)
                }
            }.frame(width: 54, height: 54)
                .background(AppColors.shadow)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(AppColors.primary, lineWidth: 1)
                )
        }
    }
}
