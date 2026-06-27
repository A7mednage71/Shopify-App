//
//  AppFonts.swift
//  Marktek
//
//  Created by Ahmed Nageh on 27/06/2026.
//

import SwiftUI

struct AppFonts {
    
    // Large Titles
    static let largeTitle = Font.system(size: 34, weight: .bold)
    static let largeTitle2 = Font.system(size: 32, weight: .semibold)
    
    // Titles
    static let title1 = Font.system(size: 28, weight: .bold)
    static let title2 = Font.system(size: 22, weight: .semibold)
    static let title3 = Font.system(size: 20, weight: .semibold)
    
    // Headlines
    static let headline = Font.system(size: 17, weight: .semibold)
    static let headline2 = Font.system(size: 17, weight: .medium)
    
    // Body
    static let body = Font.system(size: 17, weight: .regular)
    static let bodyBold = Font.system(size: 17, weight: .bold)
    static let bodySemibold = Font.system(size: 17, weight: .semibold)
    
    // Callout
    static let callout = Font.system(size: 16, weight: .regular)
    static let calloutBold = Font.system(size: 16, weight: .semibold)
    
    // Subheadline
    static let subheadline = Font.system(size: 15, weight: .regular)
    static let subheadlineBold = Font.system(size: 15, weight: .semibold)
    
    // Footnote
    static let footnote = Font.system(size: 13, weight: .regular)
    static let footnoteBold = Font.system(size: 13, weight: .semibold)
    
    // Caption
    static let caption = Font.system(size: 12, weight: .regular)
    static let captionBold = Font.system(size: 12, weight: .semibold)

    
    // Custom Font (if you want to use custom font files)
    static func customFont(name: String, size: CGFloat) -> Font {
        return Font.custom(name, size: size)
    }
}
