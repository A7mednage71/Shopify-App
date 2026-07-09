//
//  File.swift
//  Home
//
//  Created by Ahmed Nageh on 02/07/2026.
//

import Foundation
import SwiftUI
import Common

// MARK: - Trending Product Card
struct TrendingProductCard: View {
    let product: HomeProduct
    let index: Int

    private let cardWidth: CGFloat = 150
    private let cardHeight: CGFloat = 220

    var body: some View {
        ZStack(alignment: .top) {

            // Image fills the entire card
            CachedImage(urlString: product.featuredImageURL, failureImageName: "product_placeholder")
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipped()

            // Bottom gradient scrim for text legibility
            VStack(spacing: 0) {
                Spacer()
                LinearGradient(
                    colors: [.clear, .black.opacity(0.75)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 90)
            }

            // Title + price — bottom overlay
            VStack(alignment: .leading, spacing: 4) {
                Spacer()

                Text(product.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    PriceView(
                        priceInUSD: Double(product.price) ?? 0.0,
                        font: .system(size: 14, weight: .bold),
                        color: .white
                    )

                    if let compareAtPrice = product.compareAtPrice,
                       let compareAtPriceDouble = Double(compareAtPrice) {
                        PriceView(
                            priceInUSD: compareAtPriceDouble,
                            font: .system(size: 11, weight: .medium),
                            color: .white.opacity(0.7),
                            isStrikethrough: true
                        )
                    }
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)

            // Rank badge — top leading
            HStack(alignment: .top) {
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 10, weight: .bold))
                    Text("#\(index + 1)")
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(
                    Capsule().fill(
                        LinearGradient(
                            colors: [Color.appPrimaryOrange, Color.appPrimaryOrange.opacity(0.85)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                )
                .shadow(color: Color.appPrimaryOrange.opacity(0.4), radius: 4, x: 0, y: 2)

                Spacer()

                // Discount badge — top trailing
                if let discount = discountPercentage {
                    Text("-\(discount)%")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(Color.red))
                }
            }
            .padding(8)
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.appPrimaryOrange.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color.appCardShadow.opacity(0.25), radius: 10, x: 0, y: 6)
    }

    // Helper to compute discount % if compareAtPrice exists and is valid
    private var discountPercentage: Int? {
        guard let compareAtPrice = product.compareAtPrice,
              let compareValue = Double(compareAtPrice.filter { "0123456789.".contains($0) }),
              let priceValue = Double(product.price.filter { "0123456789.".contains($0) }),
              compareValue > priceValue else {
            return nil
        }
        let discount = ((compareValue - priceValue) / compareValue) * 100
        return Int(discount.rounded())
    }
}
