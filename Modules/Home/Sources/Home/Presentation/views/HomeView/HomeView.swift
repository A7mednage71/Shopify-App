import SwiftUI
import Common

public struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    @State private var sortButtonAnchor: Anchor<CGRect>?

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public init() {
        _viewModel = StateObject(wrappedValue: HomeViewModel(
            getCollectionsUseCase: HomeAssembler.resolveGetCollectionsUseCase(),
            searchProductsUseCase: HomeAssembler.resolveSearchProductsUseCase(),
            getTrendingProductsUseCase: HomeAssembler.resolveGetTrendingProductsUseCase(),
            getSpecialOffersUseCase: HomeAssembler.resolveGetSpecialOffersUseCase(),
            getProductsByVendorUseCase: HomeAssembler.resolveGetProductsByVendorUseCase()
        ))
    }

    public var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    SearchBarSection(searchText: $viewModel.searchText)
                        .padding(.top, 10)
                        .padding(.bottom, 16)

                    SortAndFilterSearch(
                        leadingLabel: viewModel.isSearching ? viewModel.resultCountLabel : HomeStrings.Category.sectionTitle,
                        onSortTap: { viewModel.showSortSheet = true },
                        onFilterTap: { viewModel.showFilterSheet = true },
                        isSortEnabled: viewModel.isSearching,
                        isFilterEnabled: viewModel.isSearching
                    )
                    .padding(.vertical, 8)

                    if viewModel.isSearching {
                        HomeSearchResultsView(viewModel: viewModel)
                            .padding(.bottom, 30)
                    } else {
                        HomeMainContentView(viewModel: viewModel)
                    }
                }
            }
            .background(Color.appBackgroundGray)
            .navigationBarTitleDisplayMode(.inline)
            .onPreferenceChange(SortButtonAnchorKey.self) { anchor in
                sortButtonAnchor = anchor
            }
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
            await viewModel.loadSpecialOffers()
        }
        .overlay(
            SortMenuOverlay(
                isPresented: $viewModel.showSortSheet,
                anchor: sortButtonAnchor,
                options: SortOption.allCases,
                selected: $viewModel.selectedSortOption,
                title: { $0.displayName },
                icon: { sortIcon(for: $0) },
                onPick: { viewModel.applySort() }
            )
        )
        .sheet(isPresented: $viewModel.showFilterSheet) {
            FilterSheet(
                filterState: $viewModel.filterState,
                availableVendors: viewModel.availableVendors,
                availableProductTypes: viewModel.availableProductTypes,
                availableTags: viewModel.availableTags,
                priceBounds: viewModel.priceBounds,
                onApply: { viewModel.applyFilter() },
                onReset: { viewModel.resetFilters() }
            )
        }
    }

    private func sortIcon(for option: SortOption) -> String {
        switch option {
        case .featured: return "star.fill"
        case .priceLowToHigh: return "arrow.up"
        case .priceHighToLow: return "arrow.down"
        case .newest: return "sparkles"
        }
    }
}
