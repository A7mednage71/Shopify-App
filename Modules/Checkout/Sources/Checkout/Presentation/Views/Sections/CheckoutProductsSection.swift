import Common
import SwiftUI

struct CheckoutProductsSection: View {
    let lines: [CartLine]
    var reviewedProductIDs: Set<String> = []
    var onReviewTap: ((CartLine) -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            CheckoutSectionHeader(title: CheckoutText.productsTitle(count: totalQuantity))

            VStack(spacing: 14) {
                ForEach(lines) { line in
                    CheckoutProductRow(
                        line: line,
                        isReviewed: line.checkoutProductID.map { reviewedProductIDs.contains($0) } ?? false,
                        onReviewTap: onReviewTap
                    )
                }
            }
        }
    }

    private var totalQuantity: Int {
        lines.reduce(0) { $0 + $1.quantity }
    }
}

private struct CheckoutProductRow: View {
    let line: CartLine
    let isReviewed: Bool
    let onReviewTap: ((CartLine) -> Void)?

    var body: some View {
        HStack(spacing: 12) {
            CheckoutRemoteImage(
                urlString: line.checkoutImageURL,
                altText: line.checkoutImageAltText
            )
            .frame(width: 76, height: 76)
            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))

            VStack(alignment: .leading, spacing: 8) {
                Text(line.checkoutProductTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .lineLimit(2)

                HStack(spacing: 8) {
                    Text(line.checkoutDetailText)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(1)

                    if line.quantity > 1 {
                        Text(CheckoutText.quantityText(line.quantity))
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(AppColors.textTertiary)
                            .lineLimit(1)
                    }
                }

                if onReviewTap != nil, line.checkoutProductID != nil {
                    Button {
                        onReviewTap?(line)
                    } label: {
                        Label(
                            isReviewed ? CheckoutText.reviewedButtonTitle : CheckoutText.reviewButtonTitle,
                            systemImage: isReviewed ? "checkmark.circle.fill" : "star.fill"
                        )
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(isReviewed ? AppColors.success : AppColors.primary)
                    }
                    .buttonStyle(.plain)
                    .disabled(isReviewed)
                }
            }

            Spacer(minLength: 8)

            Text(priceText)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
                .monospacedDigit()
        }
    }

    private var priceText: String {
        line.checkoutDisplayPrice?.checkoutFormattedCurrency() ?? "$0"
    }
}
