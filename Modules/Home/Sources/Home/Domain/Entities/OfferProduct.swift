import Foundation

public struct OfferProduct: Identifiable, Sendable {
    public let id: String
    public let title: String
    public let handle: String
    public let featuredImageURL: String?
    public let price: String
    public let currencyCode: String
    public let compareAtPrice: String?
    public let compareAtCurrencyCode: String?

    public init(
        id: String,
        title: String,
        handle: String,
        featuredImageURL: String?,
        price: String,
        currencyCode: String,
        compareAtPrice: String?,
        compareAtCurrencyCode: String?
    ) {
        self.id = id
        self.title = title
        self.handle = handle
        self.featuredImageURL = featuredImageURL
        self.price = price
        self.currencyCode = currencyCode
        self.compareAtPrice = compareAtPrice
        self.compareAtCurrencyCode = compareAtCurrencyCode
    }
}
