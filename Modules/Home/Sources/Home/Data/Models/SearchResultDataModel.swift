struct SearchResultDataModel: Sendable {
    let id: String
    let title: String
    let description: String
    let handle: String
    let featuredImageURL: String?
    let featuredImageAltText: String?
    let price: String
    let currencyCode: String
    let compareAtPrice: String?
    let compareAtCurrencyCode: String?
    let rating: String?
    let reviewCount: String?
}
