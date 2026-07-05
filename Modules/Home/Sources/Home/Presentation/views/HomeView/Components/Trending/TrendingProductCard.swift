//
//  File.swift
//  Home
//
//  Created by Ahmed Nageh on 02/07/2026.
//

import Foundation
import SwiftUICore
import SwiftUI

// MARK: - Trending Product Card (compact square)
struct TrendingProductCard: View {
    let product: HomeProduct
    let index: Int

    private let cardWidth: CGFloat = 140
    private let cardHeight: CGFloat = 190

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            // Background image — fills entire card
            Group {
                if let imageURL = product.featuredImageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .empty:
                            Rectangle()
                                .fill(Color.appBackgroundGray)
                                .overlay(ProgressView().tint(.appTextTertiary))
                        default:
                            Image("product_placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                } else {
                    Image("product_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: cardWidth, height: cardHeight)
            .clipped()

            // Gradient — stronger and taller for legibility
            LinearGradient(
                colors: [
                    .black.opacity(0),
                    .black.opacity(0),
                    .black.opacity(0.55),
                    .black.opacity(0.85)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: cardWidth, height: cardHeight)

            // Product info — overlaid on top of image
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 6) {
                    Text(product.price)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)

                    if let compareAtPrice = product.compareAtPrice {
                        Text(compareAtPrice)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white.opacity(0.65))
                            .strikethrough(true, color: .white.opacity(0.65))
                    }
                }
            }
            .padding(12)

            // Trending rank badge — top leading
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
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.appPrimaryOrange, Color.appPrimaryOrange.opacity(0.85)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .shadow(color: Color.appPrimaryOrange.opacity(0.4), radius: 4, x: 0, y: 2)
            .padding(8)
            .frame(width: cardWidth, height: cardHeight, alignment: .topLeading)

            // Discount badge — top trailing (only if on sale)
            if let discount = discountPercentage {
                Text("-\(discount)%")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(Color.red))
                    .frame(width: cardWidth, height: cardHeight, alignment: .topTrailing)
                    .padding(8)
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.appBackgroundWhite)
        .clipShape(RoundedRectangle(cornerRadius: 18))
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
