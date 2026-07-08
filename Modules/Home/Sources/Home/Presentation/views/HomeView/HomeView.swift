import SwiftUI
import Common

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    @State private var sortButtonAnchor: Anchor<CGRect>?
    private let onProductTap: ((String) -> Void)?
    private let performProtectedAction: (@escaping () -> Void) -> Void

    init(
        viewModel: HomeViewModel,
        onProductTap: ((String) -> Void)? = nil,
        performProtectedAction: @escaping (@escaping () -> Void) -> Void = { action in action() }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onProductTap = onProductTap
        self.performProtectedAction = performProtectedAction
    }


    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                        HomeSearchResultsView(viewModel: viewModel, onProductTap: { product in
                            onProductTap?(product.id)
                        }, performProtectedAction: performProtectedAction)
                        .padding(.bottom, 30)
                    } else {
                        HomeMainContentView(viewModel: viewModel, onProductTap: { product in
                            onProductTap?(product.id)
                        }, onProductTapByID: { productID in
                            onProductTap?(productID)
                        }, performProtectedAction: performProtectedAction)
                    }
                }
            }
            .onPreferenceChange(SortButtonAnchorKey.self) { anchor in
                sortButtonAnchor = anchor
            }
        }
        .background(Color.appBackgroundGray)
        .task {
            await viewModel.loadCollections()
            await viewModel.loadTrendingProducts()
            await viewModel.loadSpecialOffers()
            await viewModel.loadFavorites()
        }
        .alert(isPresented: $viewModel.showingRemoveFavoriteAlert) {
            Alert(
                title: Text(L10n.Fav.removeAlertTitle),
                message: Text(L10n.Fav.removeAlertMessage(viewModel.productToRemove?.title ?? "")),
                primaryButton: .destructive(Text(L10n.Fav.remove)) {
                    Task {
                        await viewModel.confirmRemoveFavorite()
                    }
                },
                secondaryButton: .cancel(Text(L10n.Settings.cancel)) {
                    viewModel.productToRemove = nil
                }
            )
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
