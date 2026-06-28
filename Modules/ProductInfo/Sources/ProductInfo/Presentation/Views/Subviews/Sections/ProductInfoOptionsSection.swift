import SwiftUI

struct ProductInfoOptionsSection: View {
    let options: [ProductOption]
    let selectedOptions: [String: String]
    let isValueAvailable: (ProductOption, String) -> Bool
    let onOptionSelect: (ProductOption, String) -> Void

    var body: some View {
        if !options.isEmpty {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(options) { option in
                    ProductOptionSelector(
                        option: option,
                        selectedValue: selectedOptions[option.name],
                        isColorOption: option.isColorOption,
                        isValueAvailable: { value in
                            isValueAvailable(option, value)
                        },
                        onSelect: { value in
                            onOptionSelect(option, value)
                        }
                    )
                }
            }
        }
    }
}
