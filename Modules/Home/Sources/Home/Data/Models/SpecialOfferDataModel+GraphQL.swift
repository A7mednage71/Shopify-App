@preconcurrency import MarktekNetworking

extension SpecialOfferDataModel {
    init(node: GetSpecialOffersQuery.Data.Products.Node) {
        self.id = String(node.id)
        self.title = node.title
        self.handle = node.handle
        self.featuredImageURL = node.featuredImage.map { String($0.url) }
        self.price = String(node.priceRange.minVariantPrice.amount)
        self.currencyCode = node.priceRange.minVariantPrice.currencyCode.rawValue
        self.compareAtPrice = String(node.compareAtPriceRange.minVariantPrice.amount)
        self.compareAtCurrencyCode = node.compareAtPriceRange.minVariantPrice.currencyCode.rawValue
    }
}
