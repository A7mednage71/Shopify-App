import SwiftUI

struct ProductOptionSelector: View {
    let option: ProductOption
    let selectedValue: String?
    let isColorOption: Bool
    let isValueAvailable: (String) -> Bool
    let onSelect: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(option.name)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: isColorOption ? 14 : 10) {
                    ForEach(option.values, id: \.self) { value in
                        let isSelected = selectedValue == value
                        let isAvailable = isValueAvailable(value)

                        if isColorOption {
                            ColorSwatchButton(
                                value: value,
                                isSelected: isSelected,
                                isAvailable: isAvailable,
                                action: { onSelect(value) }
                            )
                        } else {
                            OptionChipButton(
                                value: value,
                                isSelected: isSelected,
                                isAvailable: isAvailable,
                                action: { onSelect(value) }
                            )
                        }
                    }
                }
                .padding(.vertical, 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
