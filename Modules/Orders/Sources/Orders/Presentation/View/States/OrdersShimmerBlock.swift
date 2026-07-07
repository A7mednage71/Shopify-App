//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Common
import SwiftUI

struct OrdersShimmerBlock: View {
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat

    @State private var phase: CGFloat = -1.0

    init(width: CGFloat? = nil, height: CGFloat, cornerRadius: CGFloat = 12) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(AppColors.backgroundSecondary)
            .overlay {
                shimmer
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            }
            .frame(width: width, height: height)
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 1.8
                }
            }
    }

    private var shimmer: some View {
        GeometryReader { proxy in
            LinearGradient(
                colors: [
                    .clear,
                    AppColors.background.opacity(0.92),
                    .clear,
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: proxy.size.width * 0.55, height: proxy.size.height * 2.4)
            .rotationEffect(.degrees(18))
            .offset(x: proxy.size.width * phase, y: -proxy.size.height * 0.7)
        }
    }
}
