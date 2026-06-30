import Common
import SwiftUI

struct CartLineSkeletonRow: View {
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            CartShimmerBlock(width: 92, height: 92, cornerRadius: 10)

            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 8) {
                    CartShimmerBlock(height: 22, cornerRadius: 7)
                        .frame(maxWidth: 190, alignment: .leading)
                    CartShimmerBlock(height: 17, cornerRadius: 7)
                        .frame(maxWidth: 108, alignment: .leading)
                }

                CartShimmerBlock(height: 48, cornerRadius: 24)
                    .frame(maxWidth: 132, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()

            VStack(alignment: .trailing, spacing: 7) {
                CartShimmerBlock(height: 28, cornerRadius: 8)
                    .frame(maxWidth: 74, alignment: .trailing)
                CartShimmerBlock(height: 18, cornerRadius: 8)
                    .frame(maxWidth: 92, alignment: .trailing)
            }
            .frame(width: 92, alignment: .trailing)
        }
        .padding(.vertical, 20)
    }
}
