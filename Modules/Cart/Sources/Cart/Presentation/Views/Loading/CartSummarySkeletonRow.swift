import SwiftUI

struct CartSummarySkeletonRow: View {
    var body: some View {
        HStack {
            CartShimmerBlock(width: 92, height: 18, cornerRadius: 7)
            Spacer()
            CartShimmerBlock(width: 62, height: 18, cornerRadius: 7)
        }
    }
}
