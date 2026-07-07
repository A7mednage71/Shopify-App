@preconcurrency import MarktekNetworking

extension HomeProductDataModel {
    init(trendingNode node: GetTrendingProductsQuery.Data.Products.Node) {
        self.id = String(node.id)
        self.title = node.title
        self.handle = node.handle
        self.featuredImageURL = node.featuredImage.map { String($0.url) }
        self.price = String(node.priceRange.minVariantPrice.amount)
        self.currencyCode = node.priceRange.minVariantPrice.currencyCode.rawValue
        self.compareAtPrice = String(node.compareAtPriceRange.minVariantPrice.amount)
        self.compareAtCurrencyCode = node.compareAtPriceRange.minVariantPrice.currencyCode.rawValue
        
        let metafieldsData = node.metafields.compactMap { $0?.__data }
        let summary = RatingParser.calculateRating(from: metafieldsData, productId: String(node.id))
        self.rating = summary.rating
        self.reviewCount = summary.reviewCount
    }

    init(specialOfferNode node: GetSpecialOffersQuery.Data.Products.Node) {
        self.id = String(node.id)
        self.title = node.title
        self.handle = node.handle
        self.featuredImageURL = node.featuredImage.map { String($0.url) }
        self.price = String(node.priceRange.minVariantPrice.amount)
        self.currencyCode = node.priceRange.minVariantPrice.currencyCode.rawValue
        self.compareAtPrice = String(node.compareAtPriceRange.minVariantPrice.amount)
        self.compareAtCurrencyCode = node.compareAtPriceRange.minVariantPrice.currencyCode.rawValue
        
        let metafieldsData = node.metafields.compactMap { $0?.__data }
        let summary = RatingParser.calculateRating(from: metafieldsData, productId: String(node.id))
        self.rating = summary.rating
        self.reviewCount = summary.reviewCount
    }
}
