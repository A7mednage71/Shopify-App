import SwiftUI

struct ProductInfoLoadingView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ProductPalette.pageBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ProductInfoHeroSkeleton(height: geometry.size.height / 3)
                            .frame(width: geometry.size.width)

                        ProductInfoDetailsSkeleton()
                            .frame(width: geometry.size.width)
                            .offset(y: -28)
                    }
                    .frame(width: geometry.size.width)
                    .padding(.bottom, 28)
                }
                .allowsHitTesting(false)
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    ProductInfoPurchaseBarSkeleton()
                        .frame(width: geometry.size.width)
                }
            }
            .accessibilityLabel("Loading product details")
        }
    }
}

private struct ProductInfoHeroSkeleton: View {
    let height: CGFloat

    var body: some View {
        ShimmerRoundedBlock(height: height, cornerRadius: 0)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .clipped()
    }
}

private struct ProductInfoDetailsSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            thumbnailRow
            header
            stock
            optionRows
            description
            quantity
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 22)
        .padding(.top, 24)
        .padding(.bottom, 34)
        .background(ProductPalette.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
        .shadow(color: ProductPalette.shadow, radius: 20, x: 0, y: -6)
    }

    private var thumbnailRow: some View {
        HStack(spacing: 12) {
            ForEach(0..<4, id: \.self) { _ in
                ShimmerRoundedBlock(width: 68, height: 68, cornerRadius: 18)
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                ShimmerRoundedBlock(width: 190, height: 27, cornerRadius: 8)
                ShimmerRoundedBlock(width: 92, height: 15, cornerRadius: 7)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                ShimmerRoundedBlock(width: 82, height: 24, cornerRadius: 8)
                ShimmerRoundedBlock(width: 58, height: 13, cornerRadius: 7)
            }
        }
    }

    private var stock: some View {
        HStack {
            Spacer()
            ShimmerRoundedBlock(width: 94, height: 30, cornerRadius: 15)
        }
    }

    private var optionRows: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                ShimmerRoundedBlock(width: 62, height: 19, cornerRadius: 7)

                HStack(spacing: 14) {
                    ForEach(0..<4, id: \.self) { _ in
                        ShimmerCircle(diameter: 52)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                ShimmerRoundedBlock(width: 48, height: 19, cornerRadius: 7)

                HStack(spacing: 10) {
                    ForEach(0..<4, id: \.self) { _ in
                        ShimmerRoundedBlock(width: 54, height: 50, cornerRadius: 13)
                    }
                }
            }
        }
    }

    private var description: some View {
        VStack(alignment: .leading, spacing: 12) {
            ShimmerRoundedBlock(width: 108, height: 20, cornerRadius: 7)

            VStack(alignment: .leading, spacing: 8) {
                ShimmerRoundedBlock(height: 15, cornerRadius: 7)
                ShimmerRoundedBlock(height: 15, cornerRadius: 7)
                ShimmerRoundedBlock(width: 260, height: 15, cornerRadius: 7)
                ShimmerRoundedBlock(width: 96, height: 14, cornerRadius: 7)
            }
        }
    }

    private var quantity: some View {
        HStack(spacing: 16) {
            ShimmerRoundedBlock(width: 78, height: 20, cornerRadius: 7)

            Spacer()

            ShimmerRoundedBlock(width: 128, height: 46, cornerRadius: 23)
        }
    }
}

private struct ProductInfoPurchaseBarSkeleton: View {
    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 7) {
                ShimmerRoundedBlock(width: 42, height: 12, cornerRadius: 6)
                ShimmerRoundedBlock(width: 96, height: 28, cornerRadius: 8)
            }
            .frame(width: 108, alignment: .leading)

            ShimmerRoundedBlock(height: 58, cornerRadius: 29)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
        .padding(.top, 14)
        .padding(.bottom, 16)
        .background(ProductPalette.cardBackground)
        .shadow(color: ProductPalette.shadow, radius: 18, x: 0, y: -8)
    }
}
