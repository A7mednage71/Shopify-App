//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import SwiftUI
import Common

struct FavoriteProductCard: View {
    let product: FavoriteProduct
    let onRemove: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                CachedImage(urlString: product.imageURL, failureImageName: "product_placeholder")
                    .frame(width: 170, height: 180)
                    .clipped()
                    .cornerRadius(12)
                
                Button(action: onRemove) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.appPrimaryOrange)
                        .font(.system(size: 14))
                        .padding(7)
                        .background(Color.appBackgroundWhite.opacity(0.92))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                // Name
                Text(product.title)
                    .font(.productName)
                    .foregroundColor(.appTextPrimary)
                    .lineLimit(2)
                    .frame(width: 150, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Rating
                StarRatingView(rating: product.rating ?? 0.0, size: 10)
                
                Spacer(minLength: 4)
                
                // Price
                HStack(alignment: .center, spacing: 4) {
                    PriceView(priceInUSD: product.price, font: .productPrice, color: .appTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    if let compareAtPrice = product.compareAtPrice {
                        PriceView(priceInUSD: compareAtPrice, font: .productOldPrice, color: .appTextStrikePrice, isStrikethrough: true)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    
                    Spacer(minLength: 0)
                }
                .frame(width: 150)
            }
            .padding(.horizontal, 8)
            .padding(.top, 6)
            .padding(.bottom, 8)
        }
        .frame(width: 170, height: 280)
        .background(Color.appBackgroundWhite)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.appPrimaryOrange.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color.appCardShadow.opacity(0.08), radius: 6, x: 0, y: 2)
    }
}
