import Foundation

public struct ProductDetails: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let description: String
    public let descriptionHTML: String
    public let vendor: String
    public let productType: String
    public let tags: [String]
    public let availableForSale: Bool
    public let priceRange: ProductPriceRange
    public let compareAtPrice: ProductMoney
    public let images: [ProductImage]
    public let options: [ProductOption]
    public let variants: [ProductVariant]
    public let reviewSummary: ProductReviewSummary
    public let metafields: [ProductMetafield]

    public init(
        id: String,
        title: String,
        description: String,
        descriptionHTML: String,
        vendor: String,
        productType: String,
        tags: [String],
        availableForSale: Bool,
        priceRange: ProductPriceRange,
        compareAtPrice: ProductMoney,
        images: [ProductImage],
        options: [ProductOption],
        variants: [ProductVariant],
        reviewSummary: ProductReviewSummary,
        metafields: [ProductMetafield]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.descriptionHTML = descriptionHTML
        self.vendor = vendor
        self.productType = productType
        self.tags = tags
        self.availableForSale = availableForSale
        self.priceRange = priceRange
        self.compareAtPrice = compareAtPrice
        self.images = images
        self.options = options
        self.variants = variants
        self.reviewSummary = reviewSummary
        self.metafields = metafields
    }
}

public struct ProductMoney: Equatable, Sendable {
    public let amount: String
    public let currencyCode: String

    public init(amount: String, currencyCode: String) {
        self.amount = amount
        self.currencyCode = currencyCode
    }
}

public struct ProductPriceRange: Equatable, Sendable {
    public let minVariantPrice: ProductMoney
    public let maxVariantPrice: ProductMoney

    public init(minVariantPrice: ProductMoney, maxVariantPrice: ProductMoney) {
        self.minVariantPrice = minVariantPrice
        self.maxVariantPrice = maxVariantPrice
    }
}

public struct ProductImage: Identifiable, Equatable, Sendable {
    public let id: String
    public let url: String
    public let altText: String?
    public let width: Int?
    public let height: Int?

    public init(id: String?, url: String, altText: String?, width: Int?, height: Int?) {
        self.id = id ?? url
        self.url = url
        self.altText = altText
        self.width = width
        self.height = height
    }
}

public struct ProductOption: Identifiable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let values: [String]

    public init(id: String, name: String, values: [String]) {
        self.id = id
        self.name = name
        self.values = values
    }
}

public struct ProductVariant: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let availableForSale: Bool
    public let quantityAvailable: Int?
    public let price: ProductMoney
    public let compareAtPrice: ProductMoney?
    public let selectedOptions: [ProductSelectedOption]
    public let image: ProductVariantImage?

    public init(
        id: String,
        title: String,
        availableForSale: Bool,
        quantityAvailable: Int?,
        price: ProductMoney,
        compareAtPrice: ProductMoney?,
        selectedOptions: [ProductSelectedOption],
        image: ProductVariantImage?
    ) {
        self.id = id
        self.title = title
        self.availableForSale = availableForSale
        self.quantityAvailable = quantityAvailable
        self.price = price
        self.compareAtPrice = compareAtPrice
        self.selectedOptions = selectedOptions
        self.image = image
    }
}

public struct ProductSelectedOption: Equatable, Sendable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public struct ProductVariantImage: Equatable, Sendable {
    public let url: String
    public let altText: String?

    public init(url: String, altText: String?) {
        self.url = url
        self.altText = altText
    }
}

public struct ProductMetafield: Equatable, Sendable {
    public let namespace: String
    public let key: String
    public let value: String
    public let type: String

    public init(namespace: String, key: String, value: String, type: String) {
        self.namespace = namespace
        self.key = key
        self.value = value
        self.type = type
    }
}

public struct ProductReviewSummary: Equatable, Sendable {
    public let rating: Double?
    public let ratingCount: Int?

    public init(rating: Double?, ratingCount: Int?) {
        self.rating = rating
        self.ratingCount = ratingCount
    }
}
