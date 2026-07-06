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
                if let url = URL(string: product.imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .empty:
                            Rectangle()
                                .fill(Color.appBackgroundGray)
                                .overlay(
                                    ProgressView()
                                        .tint(.appPrimaryOrange)
                                )
                        case .failure(_):
                            Image("product_placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 170, height: 180)
                    .clipped()
                    .cornerRadius(12)
                } else {
                    Image("product_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 170, height: 180)
                        .clipped()
                        .cornerRadius(12)
                }
                
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
            
            VStack(alignment: .leading, spacing: 2) {
                // Name
                Text(product.title)
                    .font(.productName)
                    .foregroundColor(.appTextPrimary)
                    .lineLimit(2)
                    .frame(width: 150, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 2)
                
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
        .frame(width: 170, height: 290)
        .background(Color.appBackgroundWhite)
        .cornerRadius(14)
        .shadow(color: Color.appCardShadow.opacity(0.08), radius: 6, x: 0, y: 2)
    }
}
