import MarktekNetworking

struct ProductInfoDataModel: Sendable {
    let id: String
    let title: String
    let description: String
    let descriptionHTML: String
    let vendor: String
    let productType: String
    let tags: [String]
    let availableForSale: Bool
    let priceRange: ProductPriceRangeDataModel
    let compareAtPrice: ProductMoneyDataModel
    let images: [ProductImageDataModel]
    let options: [ProductOptionDataModel]
    let variants: [ProductVariantDataModel]
    let metafields: [ProductMetafieldDataModel]
}

struct ProductMoneyDataModel: Sendable {
    let amount: String
    let currencyCode: String
}

struct ProductPriceRangeDataModel: Sendable {
    let minVariantPrice: ProductMoneyDataModel
    let maxVariantPrice: ProductMoneyDataModel
}

struct ProductImageDataModel: Sendable {
    let id: String?
    let url: String
    let altText: String?
    let width: Int?
    let height: Int?
}

struct ProductOptionDataModel: Sendable {
    let id: String
    let name: String
    let values: [String]
}

struct ProductVariantDataModel: Sendable {
    let id: String
    let title: String
    let availableForSale: Bool
    let quantityAvailable: Int?
    let price: ProductMoneyDataModel
    let compareAtPrice: ProductMoneyDataModel?
    let selectedOptions: [ProductSelectedOptionDataModel]
    let image: ProductVariantImageDataModel?
}

struct ProductSelectedOptionDataModel: Sendable {
    let name: String
    let value: String
}

struct ProductVariantImageDataModel: Sendable {
    let url: String
    let altText: String?
}

struct ProductMetafieldDataModel: Sendable {
    let namespace: String
    let key: String
    let value: String
    let type: String
}

extension ProductInfoDataModel {
    init(product: GetProductQuery.Data.Product) {
        self.id = product.id
        self.title = product.title
        self.description = product.description
        self.descriptionHTML = product.descriptionHtml
        self.vendor = product.vendor
        self.productType = product.productType
        self.tags = product.tags
        self.availableForSale = product.availableForSale
        self.priceRange = ProductPriceRangeDataModel(
            minVariantPrice: ProductMoneyDataModel(
                amount: product.priceRange.minVariantPrice.amount,
                currencyCode: product.priceRange.minVariantPrice.currencyCode.rawValue
            ),
            maxVariantPrice: ProductMoneyDataModel(
                amount: product.priceRange.maxVariantPrice.amount,
                currencyCode: product.priceRange.maxVariantPrice.currencyCode.rawValue
            )
        )
        self.compareAtPrice = ProductMoneyDataModel(
            amount: product.compareAtPriceRange.minVariantPrice.amount,
            currencyCode: product.compareAtPriceRange.minVariantPrice.currencyCode.rawValue
        )
        self.images = product.images.edges.map { edge in
            ProductImageDataModel(
                id: edge.node.id,
                url: edge.node.url,
                altText: edge.node.altText,
                width: edge.node.width,
                height: edge.node.height
            )
        }
        self.options = product.options.map { option in
            ProductOptionDataModel(
                id: option.id,
                name: option.name,
                values: option.values
            )
        }
        self.variants = product.variants.edges.map { edge in
            ProductVariantDataModel(variant: edge.node)
        }
        self.metafields = product.metafields.compactMap { metafield in
            guard let metafield else { return nil }

            return ProductMetafieldDataModel(
                namespace: metafield.namespace,
                key: metafield.key,
                value: metafield.value,
                type: metafield.type
            )
        }
    }
}

private extension ProductVariantDataModel {
    init(variant: GetProductQuery.Data.Product.Variants.Edge.Node) {
        self.id = variant.id
        self.title = variant.title
        self.availableForSale = variant.availableForSale
        self.quantityAvailable = variant.quantityAvailable
        self.price = ProductMoneyDataModel(
            amount: variant.price.amount,
            currencyCode: variant.price.currencyCode.rawValue
        )
        self.compareAtPrice = variant.compareAtPrice.map { compareAtPrice in
            ProductMoneyDataModel(
                amount: compareAtPrice.amount,
                currencyCode: compareAtPrice.currencyCode.rawValue
            )
        }
        self.selectedOptions = variant.selectedOptions.map { selectedOption in
            ProductSelectedOptionDataModel(
                name: selectedOption.name,
                value: selectedOption.value
            )
        }
        self.image = variant.image.map { image in
            ProductVariantImageDataModel(
                url: image.url,
                altText: image.altText
            )
        }
    }
}
