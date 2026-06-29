import SwiftUI

struct ProductInfoContentView: View {
    let product: ProductDetails

    @State private var selectedImageURL: String?
    @State private var selectedOptions: [String: String]
    @State private var quantity = 1
    @State private var isFavorite = false
    @State private var isDescriptionExpanded = false

    init(product: ProductDetails) {
        self.product = product

        let initialOptions = product.initialSelectedOptions
        _selectedOptions = State(initialValue: initialOptions)
        _selectedImageURL = State(initialValue: product.initialImageURL(for: initialOptions))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ProductPalette.pageBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ProductInfoHeroSection(
                            imageURL: selectedImageURL,
                            altText: selectedGalleryImage?.altText ?? product.title,
                            height: geometry.size.height / 1.75
                        )
                        .frame(width: geometry.size.width)

                        ProductInfoDetailsContainer(
                            product: product,
                            galleryImages: galleryImages,
                            displayedImageURL: displayedImageURL,
                            visibleOptions: visibleOptions,
                            selectedOptions: selectedOptions,
                            selectedVariant: selectedVariant,
                            displayMoney: displayMoney,
                            compareAtMoney: compareAtMoney,
                            descriptionText: descriptionText,
                            isDescriptionExpanded: $isDescriptionExpanded,
                            quantity: quantity,
                            maxSelectableQuantity: maxSelectableQuantity,
                            isSelectedVariantAvailable: isSelectedVariantAvailable,
                            onImageSelect: { selectedImageURL = $0 },
                            isValueAvailable: isValueAvailable(option:value:),
                            onOptionSelect: selectOption(_:value:),
                            onQuantityDecrement: { quantity = max(1, quantity - 1) },
                            onQuantityIncrement: { quantity = min(maxSelectableQuantity, quantity + 1) }
                        )
                        .frame(width: geometry.size.width)
                        .offset(y: -28)
                    }
                    .frame(width: geometry.size.width)
                    .padding(.bottom, 28)
                }
                .ignoresSafeArea(.container, edges: .top)
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    ProductInfoPurchaseBar(
                        productTitle: product.title,
                        displayMoney: displayMoney,
                        quantity: quantity,
                        isSelectedVariantAvailable: isSelectedVariantAvailable,
                        onAddToCart: {}
                    )
                    .frame(width: geometry.size.width)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                favoriteToolbarButton
            }
        }
    }

    private var favoriteToolbarButton: some View {
        Button(action: { isFavorite.toggle() }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(isFavorite ? ProductPalette.favorite : ProductPalette.textPrimary)
        }
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
    }

    private var galleryImages: [ProductGalleryImage] {
        product.galleryImages
    }

    private var visibleOptions: [ProductOption] {
        product.options.filter { !$0.isDefaultTitleOption }
    }

    private var displayedImageURL: String? {
        selectedImageURL ?? galleryImages.first?.url
    }

    private var selectedGalleryImage: ProductGalleryImage? {
        galleryImages.first { $0.url == displayedImageURL }
    }

    private var selectedVariant: ProductVariant? {
        product.variant(matching: selectedOptions)
    }

    private var displayMoney: ProductMoney {
        selectedVariant?.price ?? product.priceRange.minVariantPrice
    }

    private var compareAtMoney: ProductMoney? {
        if let compareAtPrice = selectedVariant?.compareAtPrice,
           compareAtPrice.isGreaterThan(displayMoney) {
            return compareAtPrice
        }

        if product.compareAtPrice.isGreaterThan(displayMoney) {
            return product.compareAtPrice
        }

        return nil
    }

    private var descriptionText: String {
        product.description.isEmpty ? "No description available." : product.description
    }

    private var isSelectedVariantAvailable: Bool {
        if let selectedVariant {
            return selectedVariant.availableForSale
        }

        return product.availableForSale
    }

    private var maxSelectableQuantity: Int {
        guard isSelectedVariantAvailable else { return 1 }
        guard let quantityAvailable = selectedVariant?.quantityAvailable else { return 99 }
        return max(quantityAvailable, 1)
    }

    private func selectOption(_ option: ProductOption, value: String) {
        selectedOptions[option.name] = value

        guard let matchingVariant = product.variant(matching: selectedOptions) else { return }

        if let imageURL = matchingVariant.image?.url {
            selectedImageURL = imageURL
        }

        if let quantityAvailable = matchingVariant.quantityAvailable {
            quantity = min(quantity, max(quantityAvailable, 1))
        }
    }

    private func isValueAvailable(option: ProductOption, value: String) -> Bool {
        guard !product.variants.isEmpty else { return product.availableForSale }

        var candidateOptions = selectedOptions
        candidateOptions[option.name] = value

        return product.variants.contains { variant in
            variant.availableForSale && variant.matches(selectedOptions: candidateOptions, productOptions: product.options)
        }
    }
}
