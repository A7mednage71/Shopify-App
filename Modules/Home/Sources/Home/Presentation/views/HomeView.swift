import SwiftUI

// MARK: - Home Screen
// Assembles all sections together
// Shopify API calls should be managed via a ViewModel (HomeViewModel)

struct HomeView: View {
    @State private var searchText: String = ""
    
    // In production, inject HomeViewModel here
    // @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // ── 1. Search Bar ────────────────────────────
                    SearchBarSection(searchText: $searchText)
                        .padding(.top, 10)
                        .padding(.bottom, 16)
                    
                    Divider().padding(.horizontal, 16)
                    
                    // ── 2. Categories ────────────────────────────
                    CategorySection(
                        categories: MockShopifyData.categories,
                        onCategoryTap: { collection in
                            print("Tapped: \(collection.title)")
                        }
                    )
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    
                    // ── 3. Hero Banner Carousel ──────────────────
                    HeroBannerSection(banners: MockShopifyData.heroBanners)
                        .padding(.bottom, 20)
                    
                    // ── 4. Deal of the Day ───────────────────────
                    DealOfTheDaySection(
                        deal: MockShopifyData.dealOfDay,
                        onViewAll: { print("View all deals") }
                    )
                    .padding(.bottom, 4)
                    
                    // ── 5. Featured Product Cards ────────────────
                    ProductCardsSection(
                        products: MockShopifyData.featuredProducts,
                        onProductTap: { product in
                            print("Product: \(product.title)")
                        }
                    )
                    .padding(.bottom, 8)
                    
                    Divider().padding(.horizontal, 16)
                    
                    // ── 6. Special Offers ────────────────────────
                    SpecialOffersSection(
                        onTap: { print("Special offers tapped") }
                    )
                    .padding(.vertical, 8)
                    
                    Divider().padding(.horizontal, 16)
                    
                    // ── 7. Flat & Heels Banner ───────────────────
                    FlatHeeelsBannerSection(
                        product: MockShopifyData.featuredProducts[2],
                        onVisitTap: { print("Visit heels collection") }
                    )
                    .padding(.vertical, 16)
                    
                    // ── 8. Trending Products ─────────────────────
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
            .background(Color.backgroundWhite)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // ── Nav Bar Left: Hamburger Menu
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.textPrimary)
                            .font(.system(size: 18))
                    }
                }
                
                // ── Nav Bar Center: Logo + Name
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        // Replace with your actual logo asset:
                        // Image("app_logo").resizable().frame(width: 28, height: 28)
                        Image(systemName: "sparkles")
                            .foregroundColor(.primaryPink)
                            .font(.system(size: 20))
                        
                        Text("Stylish")
                            .font(.appBarTitle)
                            .foregroundColor(.primaryPink)
                    }
                }
                
                // ── Nav Bar Right: Profile Avatar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        AsyncImage(url: URL(string: "https://i.pravatar.cc/40")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.textTertiary)
                        }
                        .frame(width: 34, height: 34)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.primaryPink, lineWidth: 1.5))
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
