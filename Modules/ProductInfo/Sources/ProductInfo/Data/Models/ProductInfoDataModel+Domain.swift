extension ProductInfoDataModel {
    func toDomain() -> ProductDetails {
        ProductDetails(
            id: id,
            title: title,
            description: description,
            descriptionHTML: descriptionHTML,
            vendor: vendor,
            productType: productType,
            tags: tags,
            availableForSale: availableForSale,
            priceRange: priceRange.toDomain(),
            compareAtPrice: compareAtPrice.toDomain(),
            images: images.map { $0.toDomain() },
            options: options.map { $0.toDomain() },
            variants: variants.map { $0.toDomain() },
            reviews: reviews.map { $0.toDomain() },
            reviewSummary: reviewSummary
        )
    }

    private var reviewSummary: ProductReviewSummary {
        guard !reviews.isEmpty else {
            return .empty
        }

        let starCounts = reviews.reduce(into: ProductReviewSummary.empty.starCounts) { result, review in
            result[review.rating, default: 0] += 1
        }
        let ratingTotal = reviews.reduce(0) { $0 + $1.rating }

        return ProductReviewSummary(
            averageRating: Double(ratingTotal) / Double(reviews.count),
            reviewCount: reviews.count,
            starCounts: starCounts
        )
    }
}

private extension ProductMoneyDataModel {
    func toDomain() -> ProductMoney {
        ProductMoney(amount: amount, currencyCode: currencyCode)
    }
}

private extension ProductPriceRangeDataModel {
    func toDomain() -> ProductPriceRange {
        ProductPriceRange(
            minVariantPrice: minVariantPrice.toDomain(),
            maxVariantPrice: maxVariantPrice.toDomain()
        )
    }
}

private extension ProductImageDataModel {
    func toDomain() -> ProductImage {
        ProductImage(
            id: id,
            url: url,
            altText: altText,
            width: width,
            height: height
        )
    }
}

private extension ProductOptionDataModel {
    func toDomain() -> ProductOption {
        ProductOption(id: id, name: name, values: values)
    }
}

private extension ProductVariantDataModel {
    func toDomain() -> ProductVariant {
        ProductVariant(
            id: id,
            title: title,
            availableForSale: availableForSale,
            quantityAvailable: quantityAvailable,
            price: price.toDomain(),
            compareAtPrice: compareAtPrice?.toDomain(),
            selectedOptions: selectedOptions.map { $0.toDomain() },
            image: image?.toDomain()
        )
    }
}

private extension ProductSelectedOptionDataModel {
    func toDomain() -> ProductSelectedOption {
        ProductSelectedOption(name: name, value: value)
    }
}

private extension ProductVariantImageDataModel {
    func toDomain() -> ProductVariantImage {
        ProductVariantImage(url: url, altText: altText)
    }
}

private extension ProductReviewDataModel {
    func toDomain() -> ProductReview {
        ProductReview(
            id: id,
            customerName: customerName,
            rating: rating,
            title: title,
            body: body,
            createdAt: createdAt
        )
    }
}
