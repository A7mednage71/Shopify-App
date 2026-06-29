import SwiftUI

// MARK: - App Font System
// Based on Stylish App Design
// Using system SF Pro (default iOS) — swap fontName strings for custom fonts if needed

// MARK: - Font Names (swap here if using custom fonts like Poppins/Inter)
private enum AppFontName {
    static let regular  = "SF Pro Display"   // or "Poppins-Regular"
    static let medium   = "SF Pro Display"   // or "Poppins-Medium"
    static let semiBold = "SF Pro Display"   // or "Poppins-SemiBold"
    static let bold     = "SF Pro Display"   // or "Poppins-Bold"
}

// MARK: - Font Extension
extension Font {
    
    // MARK: - Display / Hero
    static let heroTitle: Font       = .system(size: 28, weight: .bold,     design: .default)    // "50-40% OFF"
    static let heroSubtitle: Font    = .system(size: 14, weight: .regular,  design: .default)    // "Now in (product)"
    
    // MARK: - Section Headings
    static let sectionTitle: Font    = .system(size: 18, weight: .bold,     design: .default)    // "All Featured", "Deal of the Day"
    static let sectionAction: Font   = .system(size: 13, weight: .medium,   design: .default)    // "View all"
    
    // MARK: - Product Card
    static let productName: Font     = .system(size: 14, weight: .semibold, design: .default)    // "Women Printed Kurta"
    static let productDesc: Font     = .system(size: 11, weight: .regular,  design: .default)    // lorem description
    static let productPrice: Font    = .system(size: 15, weight: .bold,     design: .default)    // "₹1500"
    static let productOldPrice: Font = .system(size: 12, weight: .regular,  design: .default)    // "₹2499" (strikethrough)
    static let productDiscount: Font = .system(size: 11, weight: .semibold, design: .default)    // "40% off"
    static let reviewCount: Font     = .system(size: 10, weight: .regular,  design: .default)    // "56890"
    
    // MARK: - Category Labels
    static let categoryLabel: Font   = .system(size: 11, weight: .medium,   design: .default)    // "Beauty", "Fashion"
    
    // MARK: - Search Bar
    static let searchPlaceholder: Font = .system(size: 14, weight: .regular, design: .default)   // "Search any Product..."
    
    // MARK: - Navigation / App Bar
    static let appBarTitle: Font     = .system(size: 20, weight: .bold,     design: .default)    // "Stylish"
    
    // MARK: - Timer / Countdown
    static let timerText: Font       = .system(size: 13, weight: .semibold, design: .rounded)    // "22h 55m 20s remaining"
    
    // MARK: - Button Labels
    static let buttonPrimary: Font   = .system(size: 14, weight: .semibold, design: .default)    // "Shop Now", "View all"
    static let buttonSmall: Font     = .system(size: 12, weight: .medium,   design: .default)    // small actions
    
    // MARK: - Special Offers
    static let offerTitle: Font      = .system(size: 16, weight: .bold,     design: .default)    // "Special Offers"
    static let offerSubtitle: Font   = .system(size: 12, weight: .regular,  design: .default)    // tagline
    
    // MARK: - Flat & Heels Banner
    static let bannerTitle: Font     = .system(size: 15, weight: .bold,     design: .default)    // "Flat and Heels"
    static let bannerSubtitle: Font  = .system(size: 12, weight: .regular,  design: .default)    // "Stand a chance..."
}

// MARK: - Text Style Modifiers (convenience)
extension View {
    func heroTitleStyle() -> some View {
        self.font(.heroTitle).foregroundColor(.textWhite)
    }
    func sectionTitleStyle() -> some View {
        self.font(.sectionTitle).foregroundColor(.textPrimary)
    }
    func productNameStyle() -> some View {
        self.font(.productName).foregroundColor(.textPrimary)
    }
    func productPriceStyle() -> some View {
        self.font(.productPrice).foregroundColor(.textPrimary)
    }
    func categoryLabelStyle() -> some View {
        self.font(.categoryLabel).foregroundColor(.textSecondary)
    }
}
