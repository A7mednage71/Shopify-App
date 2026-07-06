import SwiftUI
import Common

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    @State private var sortButtonAnchor: Anchor<CGRect>?
    private let onProductTap: ((String) -> Void)?

    init(viewModel: HomeViewModel, onProductTap: ((String) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onProductTap = onProductTap
    }

    @State private var showAssistant = false

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
                        })
                        .padding(.bottom, 30)
                    } else {
                        HomeMainContentView(viewModel: viewModel, onProductTap: { product in
                            onProductTap?(product.id)
                        }, onProductTapByID: { productID in
                            onProductTap?(productID)
                        })
                    }
                }
            }
            .onPreferenceChange(SortButtonAnchorKey.self) { anchor in
                sortButtonAnchor = anchor
            }

            // Floating Chatbot Button
            Button(action: { showAssistant = true }) {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(16)
                    .background(
                        LinearGradient(
                            colors: [.appPrimaryOrange, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                    .shadow(color: Color.appPrimaryOrange.opacity(0.4), radius: 8, x: 0, y: 4)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
        }
        .background(Color.appBackgroundGray)
        .task {
            await viewModel.loadCollections()
            await viewModel.loadTrendingProducts()
            await viewModel.loadSpecialOffers()
            await viewModel.loadFavorites()
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
        .sheet(isPresented: $showAssistant) {
            HomeViewFactory.makeShoppingAssistantView(onProductTap: { productID in
                showAssistant = false
                onProductTap?(productID)
            })
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
