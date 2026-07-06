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
                AsyncImage(url: URL(string: product.imageURL)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(height: 160)
                .clipped()
                
                Button(action: onRemove) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(AppColors.error)
                        .padding(8)
                        .background(Circle().fill(AppColors.textWhite).shadow(radius: 2))
                }
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PriceView(priceInUSD: product.price) 
                    .font(.headline)
            }
            .padding(12) 
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
    }
}
