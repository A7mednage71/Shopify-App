import SwiftUI

struct ShimmerRoundedBlock: View {
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
            .fill(ProductPalette.skeletonBase)
            .overlay {
                ShimmerOverlay(
                    phase: phase,
                    widthRatio: 0.55,
                    heightRatio: 2.4,
                    yOffsetRatio: -0.7
                )
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            }
            .frame(width: width, height: height)
            .onAppear {
                withAnimation(.linear(duration: 1.25).repeatForever(autoreverses: false)) {
                    phase = 1.8
                }
            }
    }

}

struct ShimmerCircle: View {
    let diameter: CGFloat

    @State private var phase: CGFloat = -1.0

    var body: some View {
        Circle()
            .fill(ProductPalette.skeletonBase)
            .overlay {
                ShimmerOverlay(
                    phase: phase,
                    widthRatio: 0.72,
                    heightRatio: 2.2,
                    yOffsetRatio: -0.6
                )
                    .clipShape(Circle())
            }
            .frame(width: diameter, height: diameter)
            .onAppear {
                withAnimation(.linear(duration: 1.25).repeatForever(autoreverses: false)) {
                    phase = 1.8
                }
            }
    }

}
