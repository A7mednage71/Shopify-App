import SwiftUI

struct StockBadge: View {
    let isAvailable: Bool
    let quantityAvailable: Int?

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(isAvailable ? ProductPalette.success : ProductPalette.error)
                .frame(width: 8, height: 8)

            Text(text)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(isAvailable ? ProductPalette.success : ProductPalette.error)
                .lineLimit(1)
                .minimumScaleFactor(0.78)
        }
        .padding(.horizontal, 11)
        .padding(.vertical, 7)
        .background((isAvailable ? ProductPalette.success : ProductPalette.error).opacity(0.1))
        .clipShape(Capsule())
    }

    private var text: String {
        guard isAvailable else { return ProductInfoText.outOfStock }
        guard let quantityAvailable else { return ProductInfoText.inStock }
        return quantityAvailable > 0 ? ProductInfoText.stockQuantity(quantityAvailable) : ProductInfoText.inStock
    }
}
