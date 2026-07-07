import SwiftUI
import Common

struct CategoryProductsView: View {
    let category: Collection
    @ObservedObject var viewModel: HomeViewModel
    var onProductTap: ((String) -> Void)? = nil
    var performProtectedAction: (@escaping () -> Void) -> Void = { action in action() }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                CategoryHeaderView(categoryName: category.title)
                
                if viewModel.isVendorProductsLoading {
                    VendorProductsSkeletonView()
                } else if let message = viewModel.vendorProductsError {
                    CommonErrorView(message: message) {
                        Task { await viewModel.loadProductsForCategory(handle: category.handle) }
                    }
                    .padding(.top, 40)
                } else if viewModel.vendorProducts.isEmpty {
                    CategoryEmptyStateView(categoryName: category.title)
                } else {
                    ProductsGridSection(
                        products: viewModel.vendorProducts,
                        favoriteProductIDs: viewModel.favoriteProductIDs,
                        onFavoriteTap: { product in
                            performProtectedAction {
                                Task {
                                    await viewModel.toggleFavorite(for: product)
                                }
                            }
                        },
                        onProductTap: onProductTap
                    )
                }
            }
        }
        .background(Color.appBackgroundGray)
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.loadProductsForCategory(handle: category.handle)
            }
        }
    }
}

struct CategoryHeaderView: View {
    let categoryName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: "square.grid.2x2.fill")
                    .foregroundColor(.appPrimaryOrange)
                    .font(.system(size: 14))
                Text("Category Collection")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.appPrimaryOrange)
                    .textCase(.uppercase)
            }
            
            Text(categoryName)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.appTextPrimary)
            
            Text("Browse all authentic products in \(categoryName)")
                .font(.system(size: 13))
                .foregroundColor(.appTextSecondary)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }
}

struct CategoryEmptyStateView: View {
    let categoryName: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image("no_products")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(.top, 60)
            
            Text("No products found")
                .font(.sectionTitle)
                .foregroundColor(.appTextPrimary)
            
            Text("We couldn't find any products listed under \(categoryName) right now.")
                .font(.offerSubtitle)
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
    }
}
