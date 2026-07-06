import Foundation
import SwiftUI

struct ProductInfoReviewsSection: View {
    let reviews: [ProductReview]
    let summary: ProductReviewSummary

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text(ProductInfoText.reviewsTitle)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textPrimary)

                Spacer()

                Text(summaryText)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textSecondary)
            }

            if reviews.isEmpty {
                emptyState
            } else {
                ratingBreakdown

                VStack(spacing: 12) {
                    ForEach(reviews) { review in
                        ProductInfoReviewCard(review: review)
                    }
                }
            }
        }
    }

    private var summaryText: String {
        guard summary.reviewCount > 0 else { return ProductInfoText.noReviewsYet }
        return "\(summary.averageRating.formattedRating) / 5"
    }

    private var emptyState: some View {
        Text(ProductInfoText.reviewEmptyMessage)
            .font(.system(size: 14, weight: .semibold, design: .rounded))
            .foregroundColor(ProductPalette.textSecondary)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ProductPalette.controlBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var ratingBreakdown: some View {
        VStack(spacing: 8) {
            ForEach((1...5).reversed(), id: \.self) { star in
                ProductInfoRatingBreakdownRow(
                    star: star,
                    count: summary.starCounts[star, default: 0],
                    total: summary.reviewCount
                )
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(ProductPalette.controlBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

private struct ProductInfoRatingBreakdownRow: View {
    let star: Int
    let count: Int
    let total: Int

    var body: some View {
        HStack(spacing: 10) {
            Text("\(star)")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textSecondary)
                .frame(width: 10, alignment: .trailing)

            Image(systemName: "star.fill")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(ProductPalette.primary)

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(ProductPalette.border.opacity(0.75))

                    Capsule()
                        .fill(ProductPalette.primary)
                        .frame(width: proxy.size.width * fraction)
                }
            }
            .frame(height: 7)

            Text("\(count)")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textTertiary)
                .frame(width: 22, alignment: .trailing)
        }
    }

    private var fraction: CGFloat {
        guard total > 0 else { return 0 }
        return CGFloat(count) / CGFloat(total)
    }
}

private struct ProductInfoReviewCard: View {
    let review: ProductReview

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundColor(ProductPalette.primary.opacity(0.85))
                    .frame(width: 38, height: 38)

                VStack(alignment: .leading, spacing: 4) {
                    Text(review.customerName)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.textPrimary)
                        .lineLimit(1)

                    HStack(spacing: 6) {
                        ProductInfoStaticStars(rating: review.rating)

                        if let dateText = review.createdAt.reviewDateText {
                            Text(dateText)
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(ProductPalette.textTertiary)
                                .lineLimit(1)
                        }
                    }
                }

                Spacer(minLength: 8)
            }

            Text(review.title)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Text(review.body)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(ProductPalette.textSecondary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .background(ProductPalette.controlBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

private struct ProductInfoStaticStars: View {
    let rating: Int

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(ProductPalette.primary)
            }
        }
    }
}

private extension Double {
    var formattedRating: String {
        String(format: "%.1f", self)
    }
}

private extension String {
    var reviewDateText: String? {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: self) else { return nil }

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .none
        return displayFormatter.string(from: date)
    }
}
