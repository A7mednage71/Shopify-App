import SwiftUI

struct ProductInfoDescriptionSection: View {
    let description: String
    let descriptionText: String
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Description")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)

            Text(descriptionText)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(ProductPalette.textSecondary)
                .lineSpacing(5)
                .lineLimit(isExpanded ? nil : 4)
                .animation(.easeInOut(duration: 0.2), value: isExpanded)

            if description.count > 160 {
                Button {
                    isExpanded.toggle()
                } label: {
                    Text(isExpanded ? "Read Less" : "Read More")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.primary)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
