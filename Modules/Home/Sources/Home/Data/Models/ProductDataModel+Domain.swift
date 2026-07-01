extension ProductDataModel {
    func toDomain() -> Product {
        Product(
            id: id,
            title: title,
            description: description,
            handle: handle,
            featuredImageURL: featuredImageURL,
            featuredImageAltText: featuredImageAltText,
            price: price,
            currencyCode: currencyCode,
            compareAtPrice: compareAtPrice,
            compareAtCurrencyCode: compareAtCurrencyCode,
            rating: rating.flatMap { Double($0) },
            reviewCount: reviewCount.flatMap { Int($0) }
        )
    }
}
