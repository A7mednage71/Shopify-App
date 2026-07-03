import SwiftUI
import Common

// MARK: - Search Results Grid

struct SearchResultsSection: View {
    let products: [ShopProduct]
    var onProductTap: ((ShopProduct) -> Void)? = nil

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if products.isEmpty {
                SearchEmptyStateView()
                    .padding(.top, 60)
                    .frame(maxWidth: .infinity)
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products) { product in
                        ShopProductCard(product: product)
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

            Text("No results found")
                .font(.sectionTitle)
                .foregroundColor(.appTextPrimary)

            Text("Try different keywords or check your spelling")
                .font(.offerSubtitle)
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
