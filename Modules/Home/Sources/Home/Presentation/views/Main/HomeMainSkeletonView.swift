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

            OfferProductCardsSection(
                products: Array(MockShopifyData.featuredProducts.prefix(2)).map {
                    HomeProduct(
                        id: $0.id,
                        title: $0.title,
                        handle: $0.handle,
                        featuredImageURL: $0.featuredImageURL,
                        price: $0.price,
                        currencyCode: $0.currencyCode,
                        compareAtPrice: $0.compareAtPrice,
                        compareAtCurrencyCode: $0.compareAtCurrencyCode
                    )
                },
                onProductTap: { _ in }
            )
            .padding(.bottom, 8)

            SpecialOffersSection(onTap: {})
                .padding(.vertical, 8)

            FlatHeeelsBannerSection(product: MockShopifyData.featuredProducts[2], onVisitTap: {})
                .padding(.vertical, 16)

            TrendingProductsSection(
                products: [
                    HomeProduct(id: "1", title: "Trending Product 1", handle: "t1", featuredImageURL: nil, price: "100.00", currencyCode: "INR", compareAtPrice: nil, compareAtCurrencyCode: nil),
                    HomeProduct(id: "2", title: "Trending Product 2", handle: "t2", featuredImageURL: nil, price: "200.00", currencyCode: "INR", compareAtPrice: nil, compareAtCurrencyCode: nil),
                    HomeProduct(id: "3", title: "Trending Product 3", handle: "t3", featuredImageURL: nil, price: "300.00", currencyCode: "INR", compareAtPrice: nil, compareAtCurrencyCode: nil)
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
