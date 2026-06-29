import SwiftUI

struct OptionChipButton: View {
    let value: String
    let isSelected: Bool
    let isAvailable: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Text(value)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(isSelected ? ProductPalette.primary : ProductPalette.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
                    .padding(.horizontal, 17)
                    .frame(minWidth: 54, minHeight: 50)
                    .background(isSelected ? ProductPalette.primary.opacity(0.1) : ProductPalette.cardBackground)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .stroke(isSelected ? ProductPalette.primary : ProductPalette.border, lineWidth: isSelected ? 2 : 1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    .opacity(isAvailable ? 1 : 0.42)

                if !isAvailable {
                    DiagonalSlash()
                        .stroke(ProductPalette.textTertiary, lineWidth: 1.4)
                        .padding(7)
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(!isAvailable)
        .accessibilityLabel(value)
    }
}
