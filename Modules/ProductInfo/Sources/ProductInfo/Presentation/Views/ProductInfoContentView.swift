import SwiftUI

struct ProductInfoContentView: View {
    let product: ProductDetails
    let addToCartState: ProductInfoAddToCartState
    @ObservedObject var comparisonViewModel: ProductComparisonViewModel
    let onCartTap: () -> Void
    let onAddToCart: (ProductVariant?, Int) -> Void

    let isFavorite: Bool
    let onFavoriteTap: () -> Void
    let onProductTap: (String) -> Void
    let performProtectedAction: (@escaping () -> Void) -> Void
    
    @State private var selectedImageURL: String?
    @State private var selectedOptions: [String: String]
    @State private var quantity = 1
    //@State private var isFavorite = false
    @State private var isDescriptionExpanded = false
    @State private var addButtonFrame: CGRect = .zero
    @State private var cartButtonFrame: CGRect = .zero
    @State private var flyProgress: CGFloat = 1
    @State private var isFlyDotVisible = false
    @State private var flyAnimationID = 0
    @State private var cartBadgeScale: CGFloat = 1
    @State private var isComparisonSheetPresented = false

    init(
        product: ProductDetails,
        addToCartState: ProductInfoAddToCartState,
        comparisonViewModel: ProductComparisonViewModel,
        isFavorite: Bool,
        onCartTap: @escaping () -> Void,
        onAddToCart: @escaping (ProductVariant?, Int) -> Void,
        onFavoriteTap: @escaping () -> Void,
        onProductTap: @escaping (String) -> Void,
        performProtectedAction: @escaping (@escaping () -> Void) -> Void = { action in action() }
    ) {
        self.product = product
        self.addToCartState = addToCartState
        self._comparisonViewModel = ObservedObject(wrappedValue: comparisonViewModel)
        self.isFavorite = isFavorite
        self.onCartTap = onCartTap
        self.onAddToCart = onAddToCart
        self.onFavoriteTap = onFavoriteTap
        self.onProductTap = onProductTap
        self.performProtectedAction = performProtectedAction

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
                            showsComparisonButton: product.normalizedProductType.isComparable,
                            onCompareTap: {
                                performProtectedAction {
                                    isComparisonSheetPresented = true
                                }
                            },
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
                        addToCartState: addToCartState,
                        onAddButtonFrameChange: { addButtonFrame = $0 },
                        onAddToCart: {
                            onAddToCart(selectedVariant, quantity)
                        }
                    )
                    .frame(width: geometry.size.width)
                }

                flyToCartDot(rootFrame: geometry.frame(in: .global))
            }
        }
        .onChange(of: addToCartState) { newValue in
            handleAddToCartStateChange(newValue)
        }
        .sheet(isPresented: $isComparisonSheetPresented) {
            ProductComparisonSheet(
                viewModel: comparisonViewModel,
                currentProduct: product,
                onProductTap: onProductTap
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ProductInfoCartToolbarButton(
                    onCartTap: onCartTap,
                    cartQuantity: cartQuantity,
                    cartBadgeScale: cartBadgeScale,
                    onFrameChange: { cartButtonFrame = $0 }
                )
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                ProductInfoFavoriteToolbarButton(
                            isFavorite: isFavorite, 
                            action: onFavoriteTap
                        )
            }
        }
    }

    @ViewBuilder
    private func flyToCartDot(rootFrame: CGRect) -> some View {
        if isFlyDotVisible {
            Circle()
                .fill(ProductPalette.primary)
                .frame(width: flyDotSize, height: flyDotSize)
                .opacity(1.0 - (Double(flyProgress) * 0.35))
                .scaleEffect(1 - (flyProgress * 0.45))
                .position(flyDotPosition(rootFrame: rootFrame))
                .allowsHitTesting(false)
                .zIndex(4)
        }
    }

    private var cartQuantity: Int? {
        if case .success(let cart) = addToCartState {
            return cart.totalQuantity
        }

        return nil
    }

    private var flyDotSize: CGFloat {
        18
    }

    private func handleAddToCartStateChange(_ state: ProductInfoAddToCartState) {
        guard case .success = state else { return }
        startFlyToCartAnimation()
    }

    private func startFlyToCartAnimation() {
        guard !addButtonFrame.isEmpty,
              !cartButtonFrame.isEmpty else {
            bumpCartBadge()
            return
        }

        flyAnimationID += 1
        let animationID = flyAnimationID

        flyProgress = 0
        isFlyDotVisible = true

        withAnimation(.easeInOut(duration: 0.72)) {
            flyProgress = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.72) {
            guard animationID == flyAnimationID else { return }
            isFlyDotVisible = false
            bumpCartBadge()
        }
    }

    private func bumpCartBadge() {
        withAnimation(.spring(response: 0.24, dampingFraction: 0.45)) {
            cartBadgeScale = 1.22
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            withAnimation(.spring(response: 0.28, dampingFraction: 0.7)) {
                cartBadgeScale = 1
            }
        }
    }

    private func flyDotPosition(rootFrame: CGRect) -> CGPoint {
        let start = CGPoint(
            x: addButtonFrame.midX - rootFrame.minX,
            y: addButtonFrame.midY - rootFrame.minY
        )
        let end = CGPoint(
            x: cartButtonFrame.midX - rootFrame.minX,
            y: cartButtonFrame.midY - rootFrame.minY
        )
        let progress = max(0, min(flyProgress, 1))
        let arcLift = -120 * sin(progress * .pi)

        return CGPoint(
            x: start.x + ((end.x - start.x) * progress),
            y: start.y + ((end.y - start.y) * progress) + arcLift
        )
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
        product.description.isEmpty ? ProductInfoText.noDescriptionAvailable : product.description
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
