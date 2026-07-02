import Foundation

// MARK: - Home Product Data Model
struct HomeProductDataModel: Sendable {
    let id: String
    let title: String
    let handle: String
    let featuredImageURL: String?
    let price: String
    let currencyCode: String
    let compareAtPrice: String?
    let compareAtCurrencyCode: String?
}
