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
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.imageURL)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(height: 160)
                .clipped()
                .cornerRadius(12)
                
                Button(action: onRemove) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Circle().fill(Color.white).shadow(radius: 2))
                }
                .padding(8)
            }
            
            Text(product.title)
                .font(.subheadline)
                .lineLimit(2)
            
            PriceView(priceInUSD: product.price)
                .font(.headline)
        }
    }
}
