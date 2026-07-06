import SwiftUI

struct ColorSwatchButton: View {
    let value: String
    let isSelected: Bool
    let isAvailable: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(ProductSwatch(value: value).color)
                    .frame(width: 42, height: 42)
                    .overlay {
                        Circle()
                            .stroke(ProductSwatch(value: value).borderColor, lineWidth: 1)
                    }

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(ProductSwatch(value: value).checkmarkColor)
                }

                if !isAvailable {
                    Circle()
                        .fill(ProductPalette.textWhite.opacity(0.58))

                    DiagonalSlash()
                        .stroke(ProductPalette.textTertiary, lineWidth: 1.5)
                        .frame(width: 42, height: 42)
                }
            }
            .frame(width: 52, height: 52)
            .background {
                Circle()
                    .stroke(isSelected ? ProductPalette.primary : .clear, lineWidth: 2.5)
            }
        }
        .buttonStyle(.plain)
        .disabled(!isAvailable)
        .accessibilityLabel(value)
    }
}
