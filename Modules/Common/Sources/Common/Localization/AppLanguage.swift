import Foundation
import SwiftUI

public enum AppLanguage: String, CaseIterable, Identifiable {
    case en = "en"
    case ar = "ar"
    
    public var id: String { self.rawValue }
    
    public var displayName: String {
        switch self {
        case .en: return LocalizationManager.shared.localizedString(for: "common_language_english")
        case .ar: return LocalizationManager.shared.localizedString(for: "common_language_arabic")
        }
    }
    
    public var layoutDirection: LayoutDirection {
        switch self {
        case .en: return .leftToRight
        case .ar: return .rightToLeft
        }
    }
}
