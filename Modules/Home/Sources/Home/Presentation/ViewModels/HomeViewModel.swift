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

    // MARK: - Use Cases

    private let getCollectionsUseCase: any GetCollectionsUseCaseProtocol

    // MARK: - Combine

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(getCollectionsUseCase: any GetCollectionsUseCaseProtocol) {
        self.getCollectionsUseCase = getCollectionsUseCase
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

    // MARK: - Search

    var resultCountLabel: String {
        "\(collections.count)+ Items"
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.isSearching = !query.trimmingCharacters(in: .whitespaces).isEmpty
            }
            .store(in: &cancellables)
    }
}
