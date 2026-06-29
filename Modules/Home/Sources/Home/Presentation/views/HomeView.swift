import SwiftUI
import Common

public struct HomeView: View {
    @State private var searchText: String = ""
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    SearchBarSection(searchText: $searchText)
                        .padding(.top, 10)
                        .padding(.bottom, 16)
                    
                    CategorySection(
                        categories: MockShopifyData.categories,
                        onCategoryTap: { collection in
                            print("Tapped: \(collection.title)")
                        }
                    )
                    .padding(.top, 16)
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
                        products: MockShopifyData.trendingProducts,
                        onViewAll: { print("View all trending") },
                        onProductTap: { product in
                            print("Trending: \(product.title)")
                        }
                    )
                    .padding(.bottom, 30)
                }
            }
            .background(Color.appBackgroundGray)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.appTextPrimary)
                            .font(.system(size: 18))
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                            .foregroundColor(.appPrimaryOrange)
                            .font(.system(size: 20))
                        Text("Marktek")
                            .font(.appBarTitle)
                            .foregroundColor(.appPrimaryOrange)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        AsyncImage(url: URL(string: "https://i.pravatar.cc/40")) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.appTextTertiary)
                        }
                        .frame(width: 34, height: 34)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.appPrimaryOrange, lineWidth: 1.5))
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
