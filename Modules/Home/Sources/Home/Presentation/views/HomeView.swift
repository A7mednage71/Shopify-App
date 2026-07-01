import SwiftUI
import Common

public struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    // Internal init — used by HomeViewFactory (same module)
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    // Public no-arg init for backwards compatibility — wires real dependencies via factory
    public init() {
        _viewModel = StateObject(wrappedValue: HomeViewModel(
            getCollectionsUseCase: HomeAssembler.resolveGetCollectionsUseCase(),
            searchProductsUseCase: HomeAssembler.resolveSearchProductsUseCase(),
            getTrendingProductsUseCase: HomeAssembler.resolveGetTrendingProductsUseCase()
        ))
    }

    public var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // Search Bar — always visible
                    SearchBarSection(searchText: $viewModel.searchText)
                        .padding(.top, 10)
                        .padding(.bottom, 16)

                    // MARK: Sort & Filter Bar — always visible
                    SortAndFilterSearch(
                        leadingLabel: viewModel.isSearching
                            ? viewModel.resultCountLabel
                            : HomeStrings.Category.sectionTitle
                    )
                    .padding(.top, 8)
                    .padding(.bottom, 8)

                    if viewModel.isSearching {
                        // MARK: Search Results
                        SearchResultsSection(
                            products: viewModel.searchResults,
                            onProductTap: { product in
                                print("Search result tapped: \(product.title)")
                            }
                        )
                        .padding(.bottom, 30)

                    } else {
                        // MARK: Categories — live data
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                        } else if let error = viewModel.error {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 16)
                        } else {
                            CategoriesListSection(
                                categories: viewModel.collections,
                                onCategoryTap: { collection in
                                    print("Tapped: \(collection.title)")
                                }
                            )
                            .padding(.bottom, 16)
                        }

                        // MARK: Remaining sections — mock data (pending future passes)
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
        .task {
            await viewModel.loadCollections()
            await viewModel.loadTrendingProducts()
        }
    }
}
