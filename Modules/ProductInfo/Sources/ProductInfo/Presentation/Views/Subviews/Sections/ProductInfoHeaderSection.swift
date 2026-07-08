import SwiftUI
import Common

struct ProductInfoHeaderSection: View {
    let title: String
    let vendor: String
    let reviewSummary: ProductReviewSummary
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

                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(ProductPalette.primary)

                    Text(reviewText)
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.textSecondary)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .layoutPriority(1)

            Spacer(minLength: 12)

                        VStack(alignment: .trailing, spacing: 4) {
                            
                            PriceView(
                                priceInUSD: Double(displayMoney.amount) ?? 0.0,
                                font: .system(size: 22, weight: .bold, design: .rounded),
                                color: ProductPalette.primary
                            )
                            .lineLimit(1)
                            .minimumScaleFactor(0.65)

                            if let compareAtMoney {
                                PriceView(
                                    priceInUSD: Double(compareAtMoney.amount) ?? 0.0,
                                    font: .system(size: 13, weight: .semibold, design: .rounded),
                                    color: ProductPalette.textTertiary,
                                    isStrikethrough: true
                                )
                                .lineLimit(1)
                            }
                        }
            .frame(width: 96, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var reviewText: String {
        guard reviewSummary.reviewCount > 0 else {
            return L10n.ProductInfo.noReviewsSummary
        }

        return L10n.ProductInfo.reviewsSummary(reviewSummary.reviewCount, rating: reviewSummary.averageRating.formattedRating)
    }
}

private extension Double {
    var formattedRating: String {
        String(format: "%.1f", self)
    }
}
