import Foundation

extension TrendingProductDataModel {
    func toDomain() -> TrendingProduct {
        TrendingProduct(
            id: id,
            title: title,
            featuredImageURL: featuredImageURL,
            featuredImageAltText: featuredImageAltText,
            price: price,
            currencyCode: currencyCode,
            compareAtPrice: compareAtPrice,
            compareAtCurrencyCode: compareAtCurrencyCode
        )
    }
}
