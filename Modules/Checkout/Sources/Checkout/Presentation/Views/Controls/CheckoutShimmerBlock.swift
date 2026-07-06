import Common
import SwiftUI

struct CheckoutShimmerBlock: View {
    let height: CGFloat
    var cornerRadius: CGFloat = 10

    @State private var isAnimating = false

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(AppColors.backgroundSecondary)
            .overlay(
                GeometryReader { proxy in
                    LinearGradient(
                        colors: [
                            AppColors.backgroundSecondary.opacity(0),
                            AppColors.textWhite.opacity(0.55),
                            AppColors.backgroundSecondary.opacity(0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: proxy.size.width * 0.75)
                    .offset(x: isAnimating ? proxy.size.width : -proxy.size.width)
                }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            )
            .frame(height: height)
            .onAppear {
                withAnimation(.linear(duration: 1.1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}
