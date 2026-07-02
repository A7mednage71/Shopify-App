import Foundation

public struct TrendingProduct: Identifiable, Sendable {
    public let id: String
    public let title: String
    public let featuredImageURL: String?
    public let featuredImageAltText: String?
    public let price: String
    public let currencyCode: String
    public let compareAtPrice: String?
    public let compareAtCurrencyCode: String?

    public init(
        id: String,
        title: String,
        featuredImageURL: String?,
        featuredImageAltText: String?,
        price: String,
        currencyCode: String,
        compareAtPrice: String?,
        compareAtCurrencyCode: String?
    ) {
        self.id = id
        self.title = title
        self.featuredImageURL = featuredImageURL
        self.featuredImageAltText = featuredImageAltText
        self.price = price
        self.currencyCode = currencyCode
        self.compareAtPrice = compareAtPrice
        self.compareAtCurrencyCode = compareAtCurrencyCode
    }
}
