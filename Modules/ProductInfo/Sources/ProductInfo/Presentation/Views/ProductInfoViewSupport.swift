import Foundation
import SwiftUI

struct ProductGalleryImage: Identifiable, Equatable {
    let id: String
    let url: String
    let altText: String?
}

struct ProductSwatch {
    let color: Color
    let borderColor: Color
    let checkmarkColor: Color

    init(value: String) {
        if let hexColor = Color(hexString: value) {
            self.color = hexColor
            self.borderColor = ProductPalette.border
            self.checkmarkColor = value.isLightHexColor ? ProductPalette.textPrimary : .white
            return
        }

        let normalizedValue = value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        switch normalizedValue {
        case "black", "jet black", "midnight":
            self.color = .black
            self.borderColor = .black
            self.checkmarkColor = .white
        case "white", "ivory", "cream":
            self.color = .white
            self.borderColor = ProductPalette.border
            self.checkmarkColor = ProductPalette.textPrimary
        case "gray", "grey", "silver":
            self.color = Color(red: 0.58, green: 0.59, blue: 0.62)
            self.borderColor = ProductPalette.border
            self.checkmarkColor = .white
        case "red", "crimson", "burgundy":
            self.color = Color(red: 0.84, green: 0.12, blue: 0.16)
            self.borderColor = .clear
            self.checkmarkColor = .white
        case "orange", "coral":
            self.color = Color(red: 0.95, green: 0.43, blue: 0.18)
            self.borderColor = .clear
            self.checkmarkColor = .white
        case "yellow", "gold":
            self.color = Color(red: 1, green: 0.78, blue: 0.18)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textPrimary
        case "green", "olive", "mint":
            self.color = Color(red: 0.02, green: 0.74, blue: 0.35)
            self.borderColor = .clear
            self.checkmarkColor = .white
        case "blue", "navy", "denim":
            self.color = Color(red: 0.10, green: 0.34, blue: 0.76)
            self.borderColor = .clear
            self.checkmarkColor = .white
        case "purple", "violet", "lavender":
            self.color = Color(red: 0.43, green: 0.29, blue: 0.84)
            self.borderColor = .clear
            self.checkmarkColor = .white
        case "pink", "rose":
            self.color = Color(red: 0.95, green: 0.42, blue: 0.62)
            self.borderColor = .clear
            self.checkmarkColor = .white
        case "brown", "tan", "camel":
            self.color = Color(red: 0.55, green: 0.32, blue: 0.18)
            self.borderColor = .clear
            self.checkmarkColor = .white
        default:
            self.color = ProductPalette.controlBackground
            self.borderColor = ProductPalette.border
            self.checkmarkColor = ProductPalette.primary
        }
    }
}

enum ProductPalette {
    static let pageBackground = Color(red: 0.956, green: 0.948, blue: 0.970)
    static let cardBackground = Color.white
    static let controlBackground = Color(red: 0.958, green: 0.958, blue: 0.970)
    static let imageBackground = Color(red: 0.918, green: 0.914, blue: 0.930)
    static let primary = Color(red: 1.0, green: 0.631, blue: 0.008)
    static let favorite = Color(red: 0.91, green: 0.22, blue: 0.34)
    static let success = Color(red: 0.13, green: 0.62, blue: 0.34)
    static let warning = Color(red: 0.96, green: 0.58, blue: 0.10)
    static let error = Color(red: 0.83, green: 0.17, blue: 0.18)
    static let textPrimary = Color(red: 0.08, green: 0.08, blue: 0.13)
    static let textSecondary = Color(red: 0.47, green: 0.47, blue: 0.55)
    static let textTertiary = Color(red: 0.62, green: 0.62, blue: 0.68)
    static let border = Color(red: 0.86, green: 0.86, blue: 0.90)
    static let disabled = Color(red: 0.70, green: 0.70, blue: 0.76)
    static let shadow = Color.black.opacity(0.12)
    static let skeletonBase = Color(red: 0.86, green: 0.86, blue: 0.90)
    static let skeletonHighlight = Color.white
}

extension ProductDetails {
    var galleryImages: [ProductGalleryImage] {
        var seenURLs: Set<String> = []
        let productImages = images.map {
            ProductGalleryImage(id: $0.id, url: $0.url, altText: $0.altText)
        }

        let variantImages = variants.compactMap { variant -> ProductGalleryImage? in
            guard let image = variant.image else { return nil }
            return ProductGalleryImage(id: "\(variant.id)-image", url: image.url, altText: image.altText)
        }

        return (productImages + variantImages).filter { image in
            seenURLs.insert(image.url).inserted
        }
    }

    var initialSelectedOptions: [String: String] {
        let selectedVariant = variants.first { $0.availableForSale } ?? variants.first
        let selectedVariantOptions = selectedVariant?.selectedOptions.reduce(into: [String: String]()) { result, option in
            result[option.name] = option.value
        } ?? [:]

        return options.reduce(into: [String: String]()) { result, option in
            result[option.name] = selectedVariantOptions[option.name] ?? option.values.first
        }
    }

    func initialImageURL(for selectedOptions: [String: String]) -> String? {
        variant(matching: selectedOptions)?.image?.url ?? galleryImages.first?.url
    }

    func variant(matching selectedOptions: [String: String]) -> ProductVariant? {
        let exactMatch = variants.first { variant in
            variant.matches(selectedOptions: selectedOptions, productOptions: options)
        }

        if let exactMatch {
            return exactMatch
        }

        return variants.first { variant in
            variant.matchesAny(selectedOptions: selectedOptions)
        }
    }
}

extension ProductVariant {
    func matches(selectedOptions: [String: String], productOptions: [ProductOption]) -> Bool {
        let variantOptions = selectedOptionsByName

        return productOptions.allSatisfy { option in
            guard let selectedValue = selectedOptions[option.name] else { return true }
            return variantOptions[option.name] == selectedValue
        }
    }

    func matchesAny(selectedOptions: [String: String]) -> Bool {
        let variantOptions = selectedOptionsByName

        return selectedOptions.contains { name, value in
            variantOptions[name] == value
        }
    }

    private var selectedOptionsByName: [String: String] {
        selectedOptions.reduce(into: [String: String]()) { result, option in
            result[option.name] = option.value
        }
    }
}

extension ProductOption {
    var isColorOption: Bool {
        let normalizedName = name.lowercased()
        return normalizedName.contains("color") || normalizedName.contains("colour")
    }

    var isDefaultTitleOption: Bool {
        name.caseInsensitiveCompare("Title") == .orderedSame
            && values.count == 1
            && values.first?.caseInsensitiveCompare("Default Title") == .orderedSame
    }
}

extension ProductMoney {
    func formatted(quantity: Int = 1) -> String {
        guard let decimalValue else {
            return "\(currencyCode) \(amount)"
        }

        let total = decimalValue * Decimal(quantity)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.minimumFractionDigits = total.isWholeNumber ? 0 : 2
        formatter.maximumFractionDigits = total.isWholeNumber ? 0 : 2

        return formatter.string(from: NSDecimalNumber(decimal: total)) ?? "\(currencyCode) \(amount)"
    }

    func isGreaterThan(_ money: ProductMoney) -> Bool {
        guard currencyCode == money.currencyCode,
              let lhs = decimalValue,
              let rhs = money.decimalValue else {
            return false
        }

        return lhs > rhs
    }

    private var decimalValue: Decimal? {
        Decimal(string: amount.replacingOccurrences(of: ",", with: ""))
    }
}

private extension Decimal {
    var isWholeNumber: Bool {
        self == rounded(scale: 0)
    }

    func rounded(scale: Int) -> Decimal {
        var value = self
        var result = Decimal()
        NSDecimalRound(&result, &value, scale, .plain)
        return result
    }
}

private extension Color {
    init?(hexString: String) {
        let sanitizedValue = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        guard sanitizedValue.count == 6,
              let value = Int(sanitizedValue, radix: 16) else {
            return nil
        }

        let red = Double((value >> 16) & 0xFF) / 255.0
        let green = Double((value >> 8) & 0xFF) / 255.0
        let blue = Double(value & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

private extension String {
    var isLightHexColor: Bool {
        let sanitizedValue = trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        guard sanitizedValue.count == 6,
              let value = Int(sanitizedValue, radix: 16) else {
            return false
        }

        let red = Double((value >> 16) & 0xFF) / 255.0
        let green = Double((value >> 8) & 0xFF) / 255.0
        let blue = Double(value & 0xFF) / 255.0
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue

        return luminance > 0.72
    }
}
