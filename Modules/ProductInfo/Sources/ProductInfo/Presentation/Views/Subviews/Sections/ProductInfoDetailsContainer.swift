import SwiftUI

struct ProductInfoDetailsContainer: View {
    let product: ProductDetails
    let galleryImages: [ProductGalleryImage]
    let displayedImageURL: String?
    let visibleOptions: [ProductOption]
    let selectedOptions: [String: String]
    let selectedVariant: ProductVariant?
    let displayMoney: ProductMoney
    let compareAtMoney: ProductMoney?
    let descriptionText: String
    @Binding var isDescriptionExpanded: Bool
    let quantity: Int
    let maxSelectableQuantity: Int
    let isSelectedVariantAvailable: Bool
    let showsComparisonButton: Bool
    let onCompareTap: () -> Void
    let onImageSelect: (String) -> Void
    let isValueAvailable: (ProductOption, String) -> Bool
    let onOptionSelect: (ProductOption, String) -> Void
    let onQuantityDecrement: () -> Void
    let onQuantityIncrement: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            if galleryImages.count > 1 {
                ProductThumbnailCarousel(
                    galleryImages: galleryImages,
                    displayedImageURL: displayedImageURL,
                    productTitle: product.title,
                    onImageSelect: onImageSelect
                )
            }

            ProductInfoHeaderSection(
                title: product.title,
                vendor: product.vendor,
                reviewSummary: product.reviewSummary,
                displayMoney: displayMoney,
                compareAtMoney: compareAtMoney
            )

            ProductInfoDescriptionSection(
                description: product.description,
                descriptionText: descriptionText,
                isExpanded: $isDescriptionExpanded
            )

            ProductInfoStockSection(
                isSelectedVariantAvailable: isSelectedVariantAvailable,
                quantityAvailable: selectedVariant?.quantityAvailable
            )

            if showsComparisonButton {
                ProductInfoComparisonSection(onCompareTap: onCompareTap)
            }

            ProductInfoOptionsSection(
                options: visibleOptions,
                selectedOptions: selectedOptions,
                isValueAvailable: isValueAvailable,
                onOptionSelect: onOptionSelect
            )

            ProductInfoQuantitySection(
                quantity: quantity,
                maxSelectableQuantity: maxSelectableQuantity,
                isSelectedVariantAvailable: isSelectedVariantAvailable,
                onDecrement: onQuantityDecrement,
                onIncrement: onQuantityIncrement
            )

            ProductInfoReviewsSection(
                reviews: product.reviews,
                summary: product.reviewSummary
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 22)
        .padding(.top, 24)
        .padding(.bottom, 34)
        .background(ProductPalette.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
        .shadow(color: ProductPalette.shadow, radius: 20, x: 0, y: -6)
    }
}
