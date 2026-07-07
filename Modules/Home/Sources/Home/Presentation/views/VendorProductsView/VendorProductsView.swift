import SwiftUI
import Common

struct VendorProductsView: View {
    let vendorName: String
    @ObservedObject var viewModel: HomeViewModel
    var onProductTap: ((String) -> Void)? = nil
    var performProtectedAction: (@escaping () -> Void) -> Void = { action in action() }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                VendorHeaderView(vendorName: vendorName)
                
                if viewModel.isVendorProductsLoading {
                    VendorProductsSkeletonView()
                } else if let message = viewModel.vendorProductsError {
                    CommonErrorView(message: message) {
                        Task { await viewModel.loadProducts(for: vendorName) }
                    }
                    .padding(.top, 40)
                } else if viewModel.vendorProducts.isEmpty {
                    VendorEmptyStateView()
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
        .navigationTitle(vendorName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.loadProducts(for: vendorName)
            }
        }
    }
}
