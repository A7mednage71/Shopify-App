import Common
import SwiftUI

struct CartLoadingView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ForEach(0..<4, id: \.self) { index in
                        CartLineSkeletonRow()

                        if index < 3 {
                            Divider()
                                .background(AppColors.border)
                                .padding(.leading, 22)
                        }
                    }
                }
                .padding(.top, 6)
                .padding(.horizontal, 22)

                CartOrderSummarySkeleton()
                    .padding(.horizontal, 22)
                    .padding(.top, 22)

                CartShimmerBlock(height: 58, cornerRadius: 18)
                    .padding(.horizontal, 22)
                    .padding(.top, 18)
                    .padding(.bottom, 26)
            }
        }
        .allowsHitTesting(false)
        .accessibilityLabel(CartText.loadingAccessibilityLabel)
    }
}
