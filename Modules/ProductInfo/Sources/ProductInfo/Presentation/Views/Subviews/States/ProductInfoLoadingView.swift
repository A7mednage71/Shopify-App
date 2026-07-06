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
            .accessibilityLabel(ProductInfoText.loadingAccessibilityLabel)
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
            ProductInfoThumbnailSkeletonRow()
            ProductInfoHeaderSkeleton()
            ProductInfoStockSkeleton()
            ProductInfoOptionsSkeleton()
            ProductInfoDescriptionSkeleton()
            ProductInfoQuantitySkeleton()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 22)
        .padding(.top, 24)
        .padding(.bottom, 34)
        .background(ProductPalette.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
        .shadow(color: ProductPalette.shadow, radius: 20, x: 0, y: -6)
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
