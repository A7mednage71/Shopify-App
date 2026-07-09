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
                    HomeHeaderView()

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
        .navigationBarHidden(true)
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

fileprivate struct HomeHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 18, weight: .semibold))
                    Text(L10n.Main.appName)
                        .font(.system(size: 16, weight: .black, design: .rounded))
                        .foregroundColor(AppColors.primary)
                }
                
                Text(L10n.Auth.welcomeBack)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.textPrimary)
            }
            
            Spacer()
            
            // Premium App Logo
            AppImages.appIcon
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .overlay(Circle().stroke(AppColors.primary.opacity(0.3), lineWidth: 2))
                .shadow(color: AppColors.primary.opacity(0.15), radius: 6, x: 0, y: 3)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}
