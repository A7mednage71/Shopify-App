import SwiftUI

// MARK: - App Color Palette
// Extracted from Stylish App Design

extension Color {
    
    // MARK: - Primary Colors
    static let primaryPink     = Color(hex: "#FF5A7E")   // CTA buttons, banners, accents
    static let primaryOrange   = Color(hex: "#F5A623")   // Deal of the Day, Trending bar
    static let primaryRed      = Color(hex: "#E8294A")   // Sale badges, hot labels
    
    // MARK: - Background Colors
    static let backgroundWhite = Color(hex: "#FFFFFF")   // Main screen background
    static let backgroundGray  = Color(hex: "#F5F5F5")   // Section backgrounds, cards
    static let backgroundLight = Color(hex: "#FAFAFA")   // Subtle section separators
    
    // MARK: - Text Colors
    static let textPrimary     = Color(hex: "#1A1A1A")   // Main headings, titles
    static let textSecondary   = Color(hex: "#666666")   // Subtitles, descriptions
    static let textTertiary    = Color(hex: "#999999")   // Placeholders, captions
    static let textWhite       = Color(hex: "#FFFFFF")   // Text on colored backgrounds
    static let textStrikePrice = Color(hex: "#AAAAAA")   // Original price (crossed out)
    
    // MARK: - Price Colors
    static let priceGreen      = Color(hex: "#2DAE7B")   // Final/discounted price
    static let discountBadge   = Color(hex: "#F5A623")   // "40% off" badge text
    
    // MARK: - Star Rating
    static let starFilled      = Color(hex: "#F5A623")   // Filled star
    static let starEmpty       = Color(hex: "#DDDDDD")   // Empty star
    
    // MARK: - Border / Divider
    static let borderLight     = Color(hex: "#EEEEEE")   // Card borders, dividers
    static let borderMedium    = Color(hex: "#DDDDDD")   // Input borders
    
    // MARK: - Search Bar
    static let searchBackground = Color(hex: "#F0F0F0")  // Search bar bg
    static let searchIcon       = Color(hex: "#AAAAAA")  // Search & mic icons
    
    // MARK: - Navigation / Tab Bar
    static let navActive        = Color(hex: "#FF5A7E")  // Active tab icon
    static let navInactive      = Color(hex: "#AAAAAA")  // Inactive tab icon
    
    // MARK: - Gradient Colors
    static let heroBannerStart  = Color(hex: "#FF5A7E")  // Hero banner gradient start
    static let heroBannerEnd    = Color(hex: "#FF8FA3")  // Hero banner gradient end
    static let dealBannerStart  = Color(hex: "#F5A623")  // Deal banner gradient start
    static let dealBannerEnd    = Color(hex: "#FFD085")  // Deal banner gradient end
}

// MARK: - Hex Color Initializer
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red:   Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
