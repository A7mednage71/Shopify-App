import SwiftUI
import Common

struct HomeMainContentView: View {
    @ObservedObject var viewModel: HomeViewModel
    var onProductTap: ((HomeProduct) -> Void)? = nil
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                HomeMainSkeletonView(viewModel: viewModel)
            } else if let error = viewModel.error {
                CommonErrorView(message: error) {
                    viewModel.retry()
                }
            } else {
                mainContent
            }
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            CategoriesListSection(
                viewModel: viewModel,
                categories: viewModel.collections,
                onCategoryTap: { collection in
                    print("Tapped: \(collection.title)")
                }
            )
            .padding(.bottom, 16)
            
            HeroBannerSection(banners: MockShopifyData.heroBanners)
                .padding(.bottom, 20)
            
            SpecialOffersSection(
                onTap: { print("Special offers tapped") }
            )
            .padding(.vertical, 8)
            
            OfferProductCardsSection(
                products: viewModel.specialOffers,
                favoriteProductIDs: viewModel.favoriteProductIDs,
                onFavoriteTap: { product in
                    Task {
                        await viewModel.toggleFavorite(for: product)
                    }
                },
                onProductTap: { product in
                    onProductTap?(product)
                }
            )
            .padding(.bottom, 8)
            
            
            FlatHeeelsBannerSection(
                product: MockShopifyData.featuredProducts[2],
                onVisitTap: { print("Visit heels collection") }
            )
            .padding(.vertical, 16)
            
            TrendingProductsSection(
                products: viewModel.trendingProducts,
                onProductTap: { product in
                    onProductTap?(product)
                }
            )
            .padding(.bottom, 30)
        }
    }
}
