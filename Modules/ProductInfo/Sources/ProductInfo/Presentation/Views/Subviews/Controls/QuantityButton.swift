import SwiftUI

struct QuantityButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(ProductPalette.textPrimary)
                .frame(width: 28, height: 28)
                .background(ProductPalette.cardBackground)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
