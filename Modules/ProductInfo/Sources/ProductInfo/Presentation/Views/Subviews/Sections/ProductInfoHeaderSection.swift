import SwiftUI

struct ProductInfoHeaderSection: View {
    let title: String
    let vendor: String
    let displayMoney: ProductMoney
    let compareAtMoney: ProductMoney?

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textPrimary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.82)
                    .fixedSize(horizontal: false, vertical: true)

                if !vendor.isEmpty {
                    Text(vendor)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(ProductPalette.textSecondary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .layoutPriority(1)

            Spacer(minLength: 12)

            VStack(alignment: .trailing, spacing: 4) {
                Text(displayMoney.formatted())
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.65)

                if let compareAtMoney {
                    Text(compareAtMoney.formatted())
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(ProductPalette.textTertiary)
                        .strikethrough()
                        .lineLimit(1)
                }
            }
            .frame(width: 96, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
