@preconcurrency import MarktekNetworking

extension TrendingProductDataModel {
    init(node: GetTrendingProductsQuery.Data.Products.Node) {
        self.id = String(node.id)
        self.title = node.title
        self.featuredImageURL = node.featuredImage.map { String($0.url) }
        self.featuredImageAltText = node.featuredImage?.altText
        self.price = String(node.priceRange.minVariantPrice.amount)
        self.currencyCode = node.priceRange.minVariantPrice.currencyCode.rawValue ?? ""
        self.compareAtPrice = String(node.compareAtPriceRange.minVariantPrice.amount)
        self.compareAtCurrencyCode = node.compareAtPriceRange.minVariantPrice.currencyCode.rawValue
    }
}
