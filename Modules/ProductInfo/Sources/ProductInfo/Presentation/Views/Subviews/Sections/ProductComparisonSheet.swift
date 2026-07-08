import Common
import SwiftUI

struct ProductComparisonSheet: View {
    @ObservedObject var viewModel: ProductComparisonViewModel
    let currentProduct: ProductDetails
    let onProductTap: (String) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    ProductComparisonHeader(productType: currentProduct.productType)

                    if viewModel.selectedProduct == nil {
                        selectionContent
                            .transition(.opacity.combined(with: .move(edge: .leading)))
                    }

                    if let selectedProduct = viewModel.selectedProduct {
                        comparisonContent(selectedProduct: selectedProduct)
                            .transition(.opacity.combined(with: .move(edge: .trailing)))
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 34)
            }
            .background(ProductPalette.pageBackground.ignoresSafeArea())
            .navigationTitle(ProductInfoText.comparisonSheetTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(ProductInfoText.closeButtonTitle) {
                        dismiss()
                    }
                }
            }
        }
        .task {
            await viewModel.loadCandidates(for: currentProduct)
        }
        .onDisappear {
            viewModel.resetForDismissal()
        }
    }

    @ViewBuilder
    private var selectionContent: some View {
        ProductComparisonSearchField(text: $viewModel.searchText)

        switch viewModel.candidatesState {
        case .idle:
            EmptyView()

        case .loading:
            ProductComparisonLoadingView(message: ProductInfoText.loadingComparableProducts)

        case .empty:
            ProductComparisonMessageView(
                title: ProductInfoText.noComparableProductsTitle,
                message: ProductInfoText.noComparableProductsMessage,
                systemImage: "square.stack.3d.up.slash"
            )

        case .failure(let message):
            ProductComparisonMessageView(
                title: ProductInfoText.comparisonLoadFailureTitle,
                message: message,
                systemImage: "exclamationmark.triangle"
            )

        case .loaded:
            if viewModel.filteredCandidates.isEmpty {
                ProductComparisonMessageView(
                    title: ProductInfoText.noSearchResultsTitle,
                    message: ProductInfoText.noSearchResultsMessage,
                    systemImage: "magnifyingglass"
                )
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.filteredCandidates) { product in
                        ProductComparisonCandidateRow(product: product) {
                            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                                viewModel.select(product)
                            }
                        }
                    }
                }
            }
        }
    }

    private func comparisonContent(selectedProduct: ProductDetails) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                withAnimation(.spring(response: 0.34, dampingFraction: 0.88)) {
                    viewModel.clearSelection()
                }
            } label: {
                Label(ProductInfoText.changeComparisonProductTitle, systemImage: "chevron.left")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.primary)
            }
            .buttonStyle(.plain)

            HStack(alignment: .top, spacing: 12) {
                ProductComparisonCard(
                    title: ProductInfoText.currentProductTitle,
                    product: currentProduct,
                    isRecommended: recommendedProductID == currentProduct.id,
                    onOpen: nil
                )

                ProductComparisonCard(
                    title: ProductInfoText.selectedProductTitle,
                    product: selectedProduct,
                    isRecommended: recommendedProductID == selectedProduct.id,
                    onOpen: {
                        dismiss()
                        onProductTap(selectedProduct.id)
                    }
                )
                .offset(x: viewModel.selectedProduct == nil ? 60 : 0)
            }

            ProductComparisonPreferenceInput(
                isExpanded: $viewModel.isPreferenceExpanded,
                text: $viewModel.comparisonPreference
            )

            Button {
                Task {
                    await viewModel.requestRecommendation(currentProduct: currentProduct)
                }
            } label: {
                HStack(spacing: 10) {
                    if case .loading = viewModel.recommendationState {
                        ProgressView()
                            .tint(ProductPalette.textWhite)
                    } else {
                        Image(systemName: "sparkles")
                            .font(.system(size: 16, weight: .bold))
                    }

                    Text(ProductInfoText.getRecommendationButtonTitle)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .foregroundColor(ProductPalette.textWhite)
                .background(ProductPalette.primary)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            .buttonStyle(.plain)
            .disabled(isRecommendationLoading)
            .opacity(isRecommendationLoading ? 0.72 : 1)

            recommendationContent(selectedProduct: selectedProduct)
        }
    }

    @ViewBuilder
    private func recommendationContent(selectedProduct: ProductDetails) -> some View {
        switch viewModel.recommendationState {
        case .idle:
            EmptyView()

        case .loading:
            ProductComparisonLoadingView(message: ProductInfoText.loadingRecommendation)

        case .failure(let message):
            ProductComparisonMessageView(
                title: ProductInfoText.recommendationFailureTitle,
                message: message,
                systemImage: "sparkles"
            )

        case .success(let recommendation):
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(ProductPalette.success)

                    Text(recommendation.confidenceLabel)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.textSecondary)
                }

                Text(recommendation.headline)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)

                Text(viewModel.displayedRecommendationText)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(ProductPalette.textPrimary)
                    .lineLimit(5)
                    .fixedSize(horizontal: false, vertical: true)

                if !recommendation.keyReasons.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(Array(recommendation.keyReasons.enumerated()), id: \.offset) { _, reason in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(ProductPalette.success)
                                    .padding(.top, 2)

                                Text(reason)
                                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                                    .foregroundColor(ProductPalette.textSecondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }

                if !recommendation.priceNote.isEmpty {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "tag.fill")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ProductPalette.primary)
                            .padding(.top, 2)

                        Text(recommendation.priceNote)
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(ProductPalette.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(10)
                    .background(ProductPalette.controlBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }

                if recommendation.recommendedProductID == selectedProduct.id {
                    Button {
                        dismiss()
                        onProductTap(selectedProduct.id)
                    } label: {
                        Label(ProductInfoText.viewRecommendedProductTitle, systemImage: "arrow.up.right")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .foregroundColor(ProductPalette.primary)
                    .background(ProductPalette.controlBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .buttonStyle(.plain)
                }
            }
            .padding(14)
            .background(ProductPalette.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(ProductPalette.border, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }

    private var isRecommendationLoading: Bool {
        if case .loading = viewModel.recommendationState { return true }
        return false
    }

    private var recommendedProductID: String? {
        if case .success(let recommendation) = viewModel.recommendationState {
            return recommendation.recommendedProductID
        }

        return nil
    }
}

private struct ProductComparisonHeader: View {
    let productType: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(ProductInfoText.compareSimilarProductsTitle)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)

            Text(ProductInfoText.compareSimilarProductsSubtitle(productType: productType))
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(ProductPalette.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct ProductComparisonSearchField: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(ProductPalette.textTertiary)

            TextField(ProductInfoText.comparisonSearchPlaceholder, text: $text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .font(.system(size: 15, weight: .medium, design: .rounded))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(ProductPalette.controlBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct ProductComparisonPreferenceInput: View {
    @Binding var isExpanded: Bool
    @Binding var text: String

    var body: some View {
        VStack(spacing: 10) {
            Button {
                withAnimation(.spring(response: 0.28, dampingFraction: 0.86)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(ProductPalette.primary)

                    Text(ProductInfoText.comparisonPreferenceTitle)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.textPrimary)

                    Spacer(minLength: 8)

                    if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(ProductPalette.success)
                    }

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(ProductPalette.textTertiary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(ProductPalette.controlBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)

            if isExpanded {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "text.bubble")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(ProductPalette.textTertiary)
                        .padding(.top, 3)

                    TextField(
                        ProductInfoText.comparisonPreferencePlaceholder,
                        text: $text,
                        axis: .vertical
                    )
                    .lineLimit(1...3)
                    .textInputAutocapitalization(.sentences)
                    .disableAutocorrection(false)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(ProductPalette.textPrimary)

                    if !text.isEmpty {
                        Button {
                            text = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(ProductPalette.textTertiary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(ProductPalette.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(ProductPalette.border, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

private struct ProductComparisonCandidateRow: View {
    let product: ProductDetails
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                ProductRemoteImage(urlString: product.images.first?.url, altText: product.title)
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                VStack(alignment: .leading, spacing: 5) {
                    Text(product.title)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(ProductPalette.textPrimary)
                        .lineLimit(2)

                    Text(product.vendor)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(ProductPalette.textSecondary)
                        .lineLimit(1)

                    ProductComparisonRatingLine(summary: product.reviewSummary)
                }

                Spacer(minLength: 8)

                PriceView(
                    priceInUSD: Double(product.priceRange.minVariantPrice.amount) ?? 0,
                    font: .system(size: 14, weight: .bold, design: .rounded),
                    color: ProductPalette.primary
                )
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            }
            .padding(12)
            .background(ProductPalette.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(ProductPalette.border, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct ProductComparisonCard: View {
    let title: String
    let product: ProductDetails
    let isRecommended: Bool
    let onOpen: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(ProductPalette.textSecondary)
                    .lineLimit(1)

                Spacer(minLength: 4)

                if isRecommended {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(ProductPalette.success)
                }
            }

            Button {
                onOpen?()
            } label: {
                ProductRemoteImage(urlString: product.images.first?.url, altText: product.title)
                    .frame(height: 112)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
            .disabled(onOpen == nil)

            Text(product.title)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            PriceView(
                priceInUSD: Double(product.priceRange.minVariantPrice.amount) ?? 0,
                font: .system(size: 15, weight: .bold, design: .rounded),
                color: ProductPalette.primary
            )
            .lineLimit(1)

            ProductComparisonRatingLine(summary: product.reviewSummary)

            VStack(alignment: .leading, spacing: 7) {
                ProductComparisonFactRow(
                    title: ProductInfoText.stockFactTitle,
                    value: product.comparisonStockText
                )
                ProductComparisonFactRow(
                    title: ProductInfoText.vendorFactTitle,
                    value: product.vendor.isEmpty ? ProductInfoText.notSpecified : product.vendor
                )
                ProductComparisonFactRow(
                    title: ProductInfoText.materialFactTitle,
                    value: product.inferredMaterial
                )
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(isRecommended ? ProductPalette.controlBackground : ProductPalette.cardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(isRecommended ? ProductPalette.success : ProductPalette.border, lineWidth: isRecommended ? 1.5 : 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct ProductComparisonRatingLine: View {
    let summary: ProductReviewSummary

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(ProductPalette.primary)

            Text(ratingText)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(ProductPalette.textSecondary)
                .lineLimit(1)
        }
    }

    private var ratingText: String {
        guard summary.reviewCount > 0 else { return ProductInfoText.noReviewsYet }
        return L10n.ProductInfo.compactReviewsSummary(summary.reviewCount, rating: String(format: "%.1f", summary.averageRating))
    }
}

private struct ProductComparisonFactRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textTertiary)
                .lineLimit(1)

            Text(value)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)
                .lineLimit(2)
                .minimumScaleFactor(0.78)
        }
    }
}

private struct ProductComparisonLoadingView: View {
    let message: String

    var body: some View {
        HStack(spacing: 12) {
            ProgressView()
                .tint(ProductPalette.primary)

            Text(message)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(ProductPalette.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(ProductPalette.controlBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct ProductComparisonMessageView: View {
    let title: String
    let message: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(ProductPalette.primary)

            Text(title)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(ProductPalette.textPrimary)
                .multilineTextAlignment(.center)

            Text(message)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundColor(ProductPalette.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(18)
        .background(ProductPalette.controlBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private extension ProductDetails {
    var comparisonStockText: String {
        guard availableForSale else { return ProductInfoText.outOfStock }
        guard let totalAvailableQuantity else { return ProductInfoText.inStock }
        return totalAvailableQuantity > 0 ? ProductInfoText.stockQuantity(totalAvailableQuantity) : ProductInfoText.inStock
    }
}

private extension ProductComparisonRecommendation {
    var confidenceLabel: String {
        L10n.ProductInfo.confidenceLabel(confidence.rawValue.capitalized)
    }
}
