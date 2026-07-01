@preconcurrency import MarktekNetworking

extension ProductDataModel {
    init(node: SearchProductsQuery.Data.Search.Node.AsProduct) {
        self.id = String(node.id)
        self.title = node.title
        self.description = node.description
        self.handle = node.handle
        self.featuredImageURL = node.featuredImage.map { String($0.url) }
        self.featuredImageAltText = node.featuredImage?.altText
        self.price = String(node.priceRange.minVariantPrice.amount)
        self.currencyCode = node.priceRange.minVariantPrice.currencyCode.rawValue ?? ""
        self.compareAtPrice = String(node.compareAtPriceRange.minVariantPrice.amount)
        self.compareAtCurrencyCode = node.compareAtPriceRange.minVariantPrice.currencyCode.rawValue
        self.rating = node.ratingMetafield?.value
        self.reviewCount = node.reviewCountMetafield?.value
    }

    init(node: GetTrendingProductsQuery.Data.Products.Node) {
        self.id = String(node.id)
        self.title = node.title
        self.description = node.description
        self.handle = node.handle
        self.featuredImageURL = node.featuredImage.map { String($0.url) }
        self.featuredImageAltText = node.featuredImage?.altText
        self.price = String(node.priceRange.minVariantPrice.amount)
        self.currencyCode = node.priceRange.minVariantPrice.currencyCode.rawValue ?? ""
        self.compareAtPrice = String(node.compareAtPriceRange.minVariantPrice.amount)
        self.compareAtCurrencyCode = node.compareAtPriceRange.minVariantPrice.currencyCode.rawValue
        self.rating = node.ratingMetafield?.value
        self.reviewCount = node.reviewCountMetafield?.value
    }
}
