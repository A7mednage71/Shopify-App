import SwiftUI
import Common

// MARK: - Search Results Grid

struct SearchResultsSection: View {
    let products: [ShopifyProduct]
    var onProductTap: ((ShopifyProduct) -> Void)? = nil

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            if products.isEmpty {
                SearchEmptyStateView()
                    .padding(.top, 60)
                    .frame(maxWidth: .infinity)
            } else {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(products) { product in
                        ProductCard(product: product, fixedWidth: nil)
                            .onTapGesture { onProductTap?(product) }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: products.count)
    }
}

// MARK: - Empty State

private struct SearchEmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50, weight: .light))
                .foregroundColor(.appBorderMedium)

            Text(L10n.Home.noResultsFound)
                .font(.sectionTitle)
                .foregroundColor(.appTextPrimary)

            Text(L10n.Home.noResultsHint)
                .font(.offerSubtitle)
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
