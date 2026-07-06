import Foundation

extension HomeProductDataModel {
    func toDomain() -> HomeProduct {
        HomeProduct(
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
