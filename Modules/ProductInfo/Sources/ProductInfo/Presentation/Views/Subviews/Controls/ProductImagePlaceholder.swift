import SwiftUI

struct ProductImagePlaceholder: View {
    var body: some View {
        ZStack {
            ProductPalette.imageBackground

            Image(systemName: "photo")
                .font(.system(size: 34, weight: .medium))
                .foregroundColor(ProductPalette.textTertiary)
        }
    }
}
