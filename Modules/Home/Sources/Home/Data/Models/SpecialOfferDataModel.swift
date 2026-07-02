import Foundation

// MARK: - Special Offer Data Model
struct SpecialOfferDataModel: Sendable {
    let id: String
    let title: String
    let handle: String
    let featuredImageURL: String?
    let price: String
    let currencyCode: String
    let compareAtPrice: String?
    let compareAtCurrencyCode: String?
}
