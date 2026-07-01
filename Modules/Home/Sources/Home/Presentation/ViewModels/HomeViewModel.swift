import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var collections: [Collection] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String? = nil

    // MARK: - Search

    @Published var searchText: String = ""
    @Published private(set) var isSearching: Bool = false
    @Published private(set) var searchResults: [Product] = []
    @Published private(set) var isSearchLoading: Bool = false

    // MARK: - Trending

    @Published private(set) var trendingProducts: [Product] = []
    @Published private(set) var isTrendingLoading: Bool = false

    // MARK: - Use Cases

    private let getCollectionsUseCase: any GetCollectionsUseCaseProtocol
    private let searchProductsUseCase: any SearchProductsUseCaseProtocol
    private let getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol

    // MARK: - Combine

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(
        getCollectionsUseCase: any GetCollectionsUseCaseProtocol,
        searchProductsUseCase: any SearchProductsUseCaseProtocol,
        getTrendingProductsUseCase: any GetTrendingProductsUseCaseProtocol
    ) {
        self.getCollectionsUseCase = getCollectionsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        self.getTrendingProductsUseCase = getTrendingProductsUseCase
        bindSearch()
    }

    // MARK: - Load

    func loadCollections() async {
        isLoading = true
        error = nil
        do {
            collections = try await getCollectionsUseCase.execute(first: 20)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }

    func loadTrendingProducts() async {
        isTrendingLoading = true
        do {
            trendingProducts = try await getTrendingProductsUseCase.execute(first: 20)
        } catch {
            self.error = error.localizedDescription
        }
        isTrendingLoading = false
    }

    // MARK: - Search

    var resultCountLabel: String {
        "\(searchResults.count) results"
    }

    private func performSearch(query: String) {
        Task {
            isSearchLoading = true
            defer { isSearchLoading = false }
            
            do {
                searchResults = try await searchProductsUseCase.execute(query: query)
            } catch {
                self.error = error.localizedDescription
                searchResults = []
            }
        }
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                let trimmed = query.trimmingCharacters(in: .whitespaces)
                self?.isSearching = !trimmed.isEmpty
                if !trimmed.isEmpty {
                    self?.performSearch(query: trimmed)
                } else {
                    self?.searchResults = []
                }
            }
            .store(in: &cancellables)
    }
}
