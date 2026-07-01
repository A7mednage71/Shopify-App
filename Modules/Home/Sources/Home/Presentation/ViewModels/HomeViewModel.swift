import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var collections: [Collection] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String? = nil

    // MARK: - Search State

    @Published var searchText: String = ""
    @Published private(set) var searchResults: [Product] = []
    @Published private(set) var searchTotalCount: Int = 0
    @Published private(set) var isSearching: Bool = false

    // MARK: - Use Cases

    private let getCollectionsUseCase: any GetCollectionsUseCaseProtocol
    private let searchProductsUseCase: any SearchProductsUseCaseProtocol

    // MARK: - Combine

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(
        getCollectionsUseCase: any GetCollectionsUseCaseProtocol,
        searchProductsUseCase: any SearchProductsUseCaseProtocol
    ) {
        self.getCollectionsUseCase = getCollectionsUseCase
        self.searchProductsUseCase = searchProductsUseCase
        bindSearch()
    }

    // MARK: - Load Collections

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

    // MARK: - Search

    var resultCountLabel: String {
        "\(searchTotalCount)+ Items"
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                let trimmed = query.trimmingCharacters(in: .whitespaces)
                if trimmed.count >= 2 {
                    Task { await self.search(query: trimmed) }
                } else {
                    self.searchResults = []
                    self.searchTotalCount = 0
                    self.isSearching = false
                }
            }
            .store(in: &cancellables)
    }

    private func search(query: String) async {
        isSearching = true
        do {
            let results = try await searchProductsUseCase.execute(query: query)
            searchResults = results
            searchTotalCount = results.count
        } catch {
            searchResults = []
            searchTotalCount = 0
        }
        isSearching = false
    }
}
