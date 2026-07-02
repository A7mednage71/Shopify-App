public struct SearchProduct: Identifiable, Sendable {
    public let id: String
    public let title: String
    public let description: String
    public let handle: String
    public let featuredImageURL: String?
    public let featuredImageAltText: String?
    public let price: String
    public let currencyCode: String
    public let compareAtPrice: String?
    public let compareAtCurrencyCode: String?
    public let rating: Double?
    public let reviewCount: Int?
    public let vendor: String?
    public let productType: String?
    public let tags: [String]
    public let availableForSale: Bool
    public let options: [ProductOption]
    public let variants: [ProductVariant]

    public init(
        id: String,
        title: String,
        description: String,
        handle: String,
        featuredImageURL: String?,
        featuredImageAltText: String?,
        price: String,
        currencyCode: String,
        compareAtPrice: String?,
        compareAtCurrencyCode: String?,
        rating: Double?,
        reviewCount: Int?,
        vendor: String? = nil,
        productType: String? = nil,
        tags: [String] = [],
        availableForSale: Bool = true,
        options: [ProductOption] = [],
        variants: [ProductVariant] = []
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.handle = handle
        self.featuredImageURL = featuredImageURL
        self.featuredImageAltText = featuredImageAltText
        self.price = price
        self.currencyCode = currencyCode
        self.compareAtPrice = compareAtPrice
        self.compareAtCurrencyCode = compareAtCurrencyCode
        self.rating = rating
        self.reviewCount = reviewCount
        self.vendor = vendor
        self.productType = productType
        self.tags = tags
        self.availableForSale = availableForSale
        self.options = options
        self.variants = variants
    }
}

public struct ProductOption: Sendable {
    public let name: String
    public let values: [String]
    
    public init(name: String, values: [String]) {
        self.name = name
        self.values = values
    }
}

public struct ProductVariant: Sendable {
    public let id: String
    public let title: String
    public let availableForSale: Bool
    public let price: String
    public let currencyCode: String
    
    public init(id: String, title: String, availableForSale: Bool, price: String, currencyCode: String) {
        self.id = id
        self.title = title
        self.availableForSale = availableForSale
        self.price = price
        self.currencyCode = currencyCode
    }
}
