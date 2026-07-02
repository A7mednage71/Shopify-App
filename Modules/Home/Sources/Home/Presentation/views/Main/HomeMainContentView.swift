import SwiftUI
import Common

struct HomeMainContentView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                HomeMainSkeletonView()
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
                categories: viewModel.collections,
                onCategoryTap: { collection in
                    print("Tapped: \(collection.title)")
                }
            )
            .padding(.bottom, 16)

            HeroBannerSection(banners: MockShopifyData.heroBanners)
                .padding(.bottom, 20)

            DealOfTheDaySection(
                deal: MockShopifyData.dealOfDay,
                onViewAll: { print("View all deals") }
            )
            .padding(.bottom, 4)

            ProductCardsSection(
                products: MockShopifyData.featuredProducts,
                onProductTap: { product in
                    print("Product: \(product.title)")
                }
            )
            .padding(.bottom, 8)

            SpecialOffersSection(
                onTap: { print("Special offers tapped") }
            )
            .padding(.vertical, 8)

            FlatHeeelsBannerSection(
                product: MockShopifyData.featuredProducts[2],
                onVisitTap: { print("Visit heels collection") }
            )
            .padding(.vertical, 16)

            TrendingProductsSection(
                products: viewModel.trendingProducts,
                onProductTap: { product in
                    print("Trending: \(product.title)")
                }
            )
            .padding(.bottom, 30)
        }
    }
}
