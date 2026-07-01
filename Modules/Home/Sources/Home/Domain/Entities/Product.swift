public struct Product: Identifiable, Sendable {
    public let id: String
    public let title: String
    public let description: String
    public let handle: String
    public let featuredImageURL: String?
    public let featuredImageAltText: String?
    public let price: String
    public let currencyCode: String
    public let compareAtPrice: String?
    public let compareAtCurrencyCode: String?
    public let rating: Double?
    public let reviewCount: Int?

    public init(
        id: String,
        title: String,
        description: String,
        handle: String,
        featuredImageURL: String?,
        featuredImageAltText: String?,
        price: String,
        currencyCode: String,
        compareAtPrice: String?,
        compareAtCurrencyCode: String?,
        rating: Double?,
        reviewCount: Int?
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.handle = handle
        self.featuredImageURL = featuredImageURL
        self.featuredImageAltText = featuredImageAltText
        self.price = price
        self.currencyCode = currencyCode
        self.compareAtPrice = compareAtPrice
        self.compareAtCurrencyCode = compareAtCurrencyCode
        self.rating = rating
        self.reviewCount = reviewCount
    }
}
