import SwiftUI

struct ProductInfoStockSection: View {
    let isSelectedVariantAvailable: Bool
    let quantityAvailable: Int?

    var body: some View {
        HStack {
            Spacer()

            StockBadge(
                isAvailable: isSelectedVariantAvailable,
                quantityAvailable: quantityAvailable
            )
        }
        .frame(maxWidth: .infinity)
    }
}
