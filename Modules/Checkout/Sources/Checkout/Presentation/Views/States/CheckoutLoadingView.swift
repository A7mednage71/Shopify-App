import Common
import SwiftUI

struct CheckoutLoadingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                CheckoutAddressSection(state: .loading)

                VStack(alignment: .leading, spacing: 14) {
                    CheckoutShimmerBlock(height: 22, cornerRadius: 8)
                        .frame(width: 132)

                    ForEach(0..<3, id: \.self) { _ in
                        HStack(spacing: 12) {
                            CheckoutShimmerBlock(height: 76, cornerRadius: 9)
                                .frame(width: 76)

                            VStack(alignment: .leading, spacing: 10) {
                                CheckoutShimmerBlock(height: 16, cornerRadius: 7)
                                    .frame(width: 180)
                                CheckoutShimmerBlock(height: 14, cornerRadius: 7)
                                    .frame(width: 120)
                            }

                            Spacer()
                        }
                    }
                }

                CheckoutShimmerBlock(height: 84, cornerRadius: 16)
                CheckoutShimmerBlock(height: 150, cornerRadius: 14)
                CheckoutShimmerBlock(height: 58, cornerRadius: 18)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 18)
        }
        .background(AppColors.background)
    }
}
