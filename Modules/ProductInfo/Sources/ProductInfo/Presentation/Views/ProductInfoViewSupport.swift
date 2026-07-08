import Common
import Foundation
import SwiftUI

struct ProductInfoFrameReader: View {
    let onChange: (CGRect) -> Void

    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)

            Color.clear
                .onAppear {
                    onChange(frame)
                }
                .onChange(of: frame) { newFrame in
                    onChange(newFrame)
                }
        }
    }
}

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
            self.checkmarkColor = value.isLightHexColor ? ProductPalette.textPrimary : ProductPalette.textWhite
            return
        }

        let normalizedValue = value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        switch normalizedValue {
        case "black", "jet black", "midnight":
            self.color = .black
            self.borderColor = .black
            self.checkmarkColor = ProductPalette.textWhite
        case "white", "ivory", "cream":
            self.color = .white
            self.borderColor = ProductPalette.border
            self.checkmarkColor = ProductPalette.textPrimary
        case "gray", "grey", "silver":
            self.color = Color(red: 0.58, green: 0.59, blue: 0.62)
            self.borderColor = ProductPalette.border
            self.checkmarkColor = ProductPalette.textWhite
        case "red", "crimson", "burgundy":
            self.color = Color(red: 0.84, green: 0.12, blue: 0.16)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textWhite
        case "orange", "coral":
            self.color = Color(red: 0.95, green: 0.43, blue: 0.18)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textWhite
        case "yellow", "gold":
            self.color = Color(red: 1, green: 0.78, blue: 0.18)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textPrimary
        case "green", "olive", "mint":
            self.color = Color(red: 0.02, green: 0.74, blue: 0.35)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textWhite
        case "blue", "navy", "denim":
            self.color = Color(red: 0.10, green: 0.34, blue: 0.76)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textWhite
        case "purple", "violet", "lavender":
            self.color = Color(red: 0.43, green: 0.29, blue: 0.84)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textWhite
        case "pink", "rose":
            self.color = Color(red: 0.95, green: 0.42, blue: 0.62)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textWhite
        case "brown", "tan", "camel":
            self.color = Color(red: 0.55, green: 0.32, blue: 0.18)
            self.borderColor = .clear
            self.checkmarkColor = ProductPalette.textWhite
        default:
            self.color = ProductPalette.controlBackground
            self.borderColor = ProductPalette.border
            self.checkmarkColor = ProductPalette.primary
        }
    }
}

enum ProductPalette {
    static let pageBackground = AppColors.background
    static let cardBackground = AppColors.background
    static let controlBackground = AppColors.backgroundSecondary
    static let imageBackground = AppColors.backgroundSecondary
    static let primary = AppColors.primary
    static let favorite = AppColors.secondary
    static let success = AppColors.success
    static let warning = AppColors.primaryDark
    static let error = AppColors.error
    static let textPrimary = AppColors.textPrimary
    static let textSecondary = AppColors.textSecondary
    static let textTertiary = AppColors.textTertiary
    static let textWhite = AppColors.textWhite
    static let border = AppColors.border
    static let disabled = AppColors.disabled
    static let shadow = AppColors.shadow
    static let skeletonBase = AppColors.border
    static let skeletonHighlight = AppColors.textWhite
}

enum ProductInfoText {
    static var productLoadFailureTitle: String { L10n.ProductInfo.productLoadFailureTitle }
    static var retryButtonTitle: String { L10n.ProductInfo.retryButtonTitle }
    static var retryAccessibilityLabel: String { L10n.ProductInfo.retryAccessibilityLabel }
    static var failureHelpMessage: String { L10n.ProductInfo.failureHelpMessage }
    static var failureFallbackMessage: String { L10n.ProductInfo.failureFallbackMessage }
    static var loadingAccessibilityLabel: String { L10n.ProductInfo.loadingAccessibilityLabel }
    static var productImageAccessibilityLabel: String { L10n.ProductInfo.productImageAccessibilityLabel }
    static var selectAvailableVariantMessage: String { L10n.ProductInfo.selectAvailableVariantMessage }
    static var viewCartAccessibilityLabel: String { L10n.ProductInfo.viewCartAccessibilityLabel }
    static var removeFromFavoritesAccessibilityLabel: String { L10n.ProductInfo.removeFromFavoritesAccessibilityLabel }
    static var addToFavoritesAccessibilityLabel: String { L10n.ProductInfo.addToFavoritesAccessibilityLabel }
    static var noDescriptionAvailable: String { L10n.ProductInfo.noDescriptionAvailable }
    static var descriptionTitle: String { L10n.ProductInfo.descriptionTitle }
    static var reviewsTitle: String { L10n.ProductInfo.reviewsTitle }
    static var compareProductsTitle: String { L10n.ProductInfo.compareProductsTitle }
    static var compareProductsSubtitle: String { L10n.ProductInfo.compareProductsSubtitle }
    static var comparisonSheetTitle: String { L10n.ProductInfo.comparisonSheetTitle }
    static var closeButtonTitle: String { L10n.ProductInfo.closeButtonTitle }
    static var loadingComparableProducts: String { L10n.ProductInfo.loadingComparableProducts }
    static var noComparableProductsTitle: String { L10n.ProductInfo.noComparableProductsTitle }
    static var noComparableProductsMessage: String { L10n.ProductInfo.noComparableProductsMessage }
    static var comparisonLoadFailureTitle: String { L10n.ProductInfo.comparisonLoadFailureTitle }
    static var noSearchResultsTitle: String { L10n.ProductInfo.noSearchResultsTitle }
    static var noSearchResultsMessage: String { L10n.ProductInfo.noSearchResultsMessage }
    static var changeComparisonProductTitle: String { L10n.ProductInfo.changeComparisonProductTitle }
    static var currentProductTitle: String { L10n.ProductInfo.currentProductTitle }
    static var selectedProductTitle: String { L10n.ProductInfo.selectedProductTitle }
    static var comparisonPreferenceTitle: String { L10n.ProductInfo.comparisonPreferenceTitle }
    static var comparisonPreferencePlaceholder: String { L10n.ProductInfo.comparisonPreferencePlaceholder }
    static var getRecommendationButtonTitle: String { L10n.ProductInfo.getRecommendationButtonTitle }
    static var loadingRecommendation: String { L10n.ProductInfo.loadingRecommendation }
    static var recommendationFailureTitle: String { L10n.ProductInfo.recommendationFailureTitle }
    static var viewRecommendedProductTitle: String { L10n.ProductInfo.viewRecommendedProductTitle }
    static var compareSimilarProductsTitle: String { L10n.ProductInfo.compareSimilarProductsTitle }
    static var comparisonSearchPlaceholder: String { L10n.ProductInfo.comparisonSearchPlaceholder }
    static var stockFactTitle: String { L10n.ProductInfo.stockFactTitle }
    static var vendorFactTitle: String { L10n.ProductInfo.vendorFactTitle }
    static var materialFactTitle: String { L10n.ProductInfo.materialFactTitle }
    static var notSpecified: String { L10n.ProductInfo.notSpecified }
    static var noReviewsYet: String { L10n.ProductInfo.noReviewsYet }
    static var reviewEmptyMessage: String { L10n.ProductInfo.reviewEmptyMessage }
    static var readLessButtonTitle: String { L10n.ProductInfo.readLessButtonTitle }
    static var readMoreButtonTitle: String { L10n.ProductInfo.readMoreButtonTitle }
    static var quantityTitle: String { L10n.ProductInfo.quantityTitle }
    static var totalTitle: String { L10n.ProductInfo.totalTitle }
    static var addingToCartButtonTitle: String { L10n.ProductInfo.addingToCartButtonTitle }
    static var addToCartButtonTitle: String { L10n.ProductInfo.addToCartButtonTitle }
    static var outOfStock: String { L10n.ProductInfo.outOfStock }
    static var inStock: String { L10n.ProductInfo.inStock }
    static var colorOptionName: String { L10n.ProductInfo.colorOptionName }
    static var colourOptionName: String { L10n.ProductInfo.colourOptionName }
    static var defaultTitleOptionName: String { L10n.ProductInfo.defaultTitleOptionName }
    static var defaultVariantTitle: String { L10n.ProductInfo.defaultVariantTitle }

    static func stockQuantity(_ quantity: Int) -> String {
        L10n.ProductInfo.stockQuantity(quantity)
    }

    static func compareSimilarProductsSubtitle(productType: String) -> String {
        let trimmedType = productType.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedType.isEmpty else {
            return L10n.ProductInfo.compareMatchingCatalogItems
        }

        return L10n.ProductInfo.compareOtherItems(trimmedType)
    }

    static func addToCartAccessibilityLabel(productTitle: String) -> String {
        L10n.ProductInfo.addToCartAccessibilityLabel(productTitle)
    }
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
        return normalizedName.contains("color")
            || normalizedName.contains("colour")
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
