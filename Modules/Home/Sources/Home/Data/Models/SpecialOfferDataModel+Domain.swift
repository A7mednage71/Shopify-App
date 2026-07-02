import Foundation

extension SpecialOfferDataModel {
    func toDomain() -> OfferProduct {
        OfferProduct(
            id: id,
            title: title,
            handle: handle,
            featuredImageURL: featuredImageURL,
            price: price,
            currencyCode: currencyCode,
            compareAtPrice: compareAtPrice,
            compareAtCurrencyCode: compareAtCurrencyCode
        )
    }
}
