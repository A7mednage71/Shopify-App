import SwiftUI

struct ProductInfoThumbnailSkeletonRow: View {
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<4, id: \.self) { _ in
                ShimmerRoundedBlock(width: 68, height: 68, cornerRadius: 18)
            }
        }
    }
}

struct ProductInfoHeaderSkeleton: View {
    var body: some View {
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
}

struct ProductInfoStockSkeleton: View {
    var body: some View {
        HStack {
            Spacer()
            ShimmerRoundedBlock(width: 94, height: 30, cornerRadius: 15)
        }
    }
}

struct ProductInfoOptionsSkeleton: View {
    var body: some View {
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
}

struct ProductInfoDescriptionSkeleton: View {
    var body: some View {
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
}

struct ProductInfoQuantitySkeleton: View {
    var body: some View {
        HStack(spacing: 16) {
            ShimmerRoundedBlock(width: 78, height: 20, cornerRadius: 7)

            Spacer()

            ShimmerRoundedBlock(width: 128, height: 46, cornerRadius: 23)
        }
    }
}
