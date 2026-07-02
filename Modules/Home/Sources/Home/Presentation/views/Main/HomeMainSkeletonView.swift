import SwiftUI
import Common
import Shimmer

struct HomeMainSkeletonView: View {
    var body: some View {
        VStack(spacing: 0) {
            CategoriesListSection(
                categories: [
                    Collection(id: "1", title: "Beauty", handle: "beauty", imageURL: nil),
                    Collection(id: "2", title: "Fashion", handle: "fashion", imageURL: nil),
                    Collection(id: "3", title: "Kids", handle: "kids", imageURL: nil),
                    Collection(id: "4", title: "Mens", handle: "mens", imageURL: nil),
                    Collection(id: "5", title: "Womens", handle: "womens", imageURL: nil)
                ],
                onCategoryTap: { _ in }
            )
            .padding(.bottom, 16)

            HeroBannerSection(banners: MockShopifyData.heroBanners)
                .padding(.bottom, 20)

            DealOfTheDaySection(deal: MockShopifyData.dealOfDay, onViewAll: {})
                .padding(.bottom, 4)

            ProductCardsSection(products: Array(MockShopifyData.featuredProducts.prefix(2)), onProductTap: { _ in })
                .padding(.bottom, 8)

            SpecialOffersSection(onTap: {})
                .padding(.vertical, 8)

            FlatHeeelsBannerSection(product: MockShopifyData.featuredProducts[2], onVisitTap: {})
                .padding(.vertical, 16)

            TrendingProductsSection(
                products: [
                    TrendingProduct(id: "1", title: "Trending Product 1", featuredImageURL: nil, featuredImageAltText: nil, price: "100.00", currencyCode: "INR", compareAtPrice: nil, compareAtCurrencyCode: nil),
                    TrendingProduct(id: "2", title: "Trending Product 2", featuredImageURL: nil, featuredImageAltText: nil, price: "200.00", currencyCode: "INR", compareAtPrice: nil, compareAtCurrencyCode: nil),
                    TrendingProduct(id: "3", title: "Trending Product 3", featuredImageURL: nil, featuredImageAltText: nil, price: "300.00", currencyCode: "INR", compareAtPrice: nil, compareAtCurrencyCode: nil)
                ],
                onProductTap: { _ in }
            )
            .padding(.bottom, 30)
        }
        .redacted(reason: .placeholder)
        .shimmering()
        .disabled(true)
    }
}
