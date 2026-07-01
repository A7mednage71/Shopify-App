import SwiftUI

struct ShimmerOverlay: View {
    let phase: CGFloat
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    let yOffsetRatio: CGFloat

    var body: some View {
        GeometryReader { proxy in
            LinearGradient(
                colors: [
                    .clear,
                    ProductPalette.skeletonHighlight.opacity(0.85),
                    .clear,
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: proxy.size.width * widthRatio, height: proxy.size.height * heightRatio)
            .rotationEffect(.degrees(18))
            .offset(x: proxy.size.width * phase, y: proxy.size.height * yOffsetRatio)
        }
    }
}
