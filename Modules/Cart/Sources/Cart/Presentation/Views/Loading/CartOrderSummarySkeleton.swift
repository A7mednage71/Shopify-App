import Common
import SwiftUI

struct CartOrderSummarySkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            CartShimmerBlock(width: 170, height: 25, cornerRadius: 8)

            VStack(spacing: 13) {
                CartSummarySkeletonRow()
                CartSummarySkeletonRow()

                Divider()
                    .background(AppColors.border)
                    .padding(.top, 10)

                CartSummarySkeletonRow()
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
