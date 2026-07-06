//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import SwiftUI

@available(iOS 14.0, *)
public struct PriceView: View {
    let priceInUSD: Double
    
    var font: Font
    var color: Color
    var isStrikethrough: Bool
    
    @AppStorage("selectedCurrency") private var selectedCurrency: AppCurrency = .usd
    
    public init(
        priceInUSD: Double,
        font: Font = AppFonts.headline,
        color: Color = AppColors.textPrimary,
        isStrikethrough: Bool = false
    ) {
        self.priceInUSD = priceInUSD
        self.font = font
        self.color = color
        self.isStrikethrough = isStrikethrough
    }
    
    public var body: some View {
        Text(formattedPrice)
            .font(font)
            .foregroundColor(color)
            .strikethrough(isStrikethrough)
    }
    
    private var formattedPrice: String {
        let convertedPrice = priceInUSD * selectedCurrency.exchangeRateFromUSD
        return String(format: "%.2f %@", convertedPrice, selectedCurrency.symbol)
    }
}
