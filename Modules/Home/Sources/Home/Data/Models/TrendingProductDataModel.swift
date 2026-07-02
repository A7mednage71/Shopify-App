import Foundation

// MARK: - Trending Product Data Model
struct TrendingProductDataModel: Sendable {
    let id: String
    let title: String
    let featuredImageURL: String?
    let featuredImageAltText: String?
    let price: String
    let currencyCode: String
    let compareAtPrice: String?
    let compareAtCurrencyCode: String?
}
