import Foundation

extension SearchProductNode {
    func toDomain() -> SearchProduct {
        let imageURL = images.edges.first?.node.url
        let altText = images.edges.first?.node.altText
        let minPrice = priceRange.minVariantPrice.amount
        let currency = priceRange.minVariantPrice.currencyCode
        
        let productOptions = options.map { option in
            ProductOption(name: option.name, values: option.values)
        }
        
        let productVariants = variants.edges.map { edge in
            ProductVariant(
                id: edge.node.id,
                title: edge.node.title,
                availableForSale: edge.node.availableForSale,
                price: edge.node.price.amount,
                currencyCode: edge.node.price.currencyCode
            )
        }
        
        return SearchProduct(
            id: id,
            title: title,
            description: description,
            handle: handle,
            featuredImageURL: imageURL,
            featuredImageAltText: altText,
            price: minPrice,
            currencyCode: currency,
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: nil,
            reviewCount: nil,
            vendor: vendor,
            productType: productType,
            tags: tags,
            availableForSale: availableForSale,
            options: productOptions,
            variants: productVariants
        )
    }
}
