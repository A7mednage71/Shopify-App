import SwiftUI

struct ProductInfoAddToCartButtonContent: View {
    let isAddingToCart: Bool

    var body: some View {
        if isAddingToCart {
            HStack(spacing: 8) {
                ProgressView()
                    .controlSize(.small)
                    .tint(ProductPalette.textWhite)

                Text(ProductInfoText.addingToCartButtonTitle)
            }
        } else {
            Label(ProductInfoText.addToCartButtonTitle, systemImage: "bag")
        }
    }
}
