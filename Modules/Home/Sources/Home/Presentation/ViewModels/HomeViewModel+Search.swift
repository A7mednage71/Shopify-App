import Foundation
import Common
import Combine

extension HomeViewModel {
    
    var resultCountLabel: String {
        L10n.HomeStrs.resultsCount(searchResults.count)
    }

    func performSearch(query: String) {
        Task {
            isSearchLoading = true
            defer { isSearchLoading = false }
            
            do {
                let results = try await searchProductsUseCase.execute(query: query)
                searchResults = results
                originalSearchResults = results
                extractFilterOptions(from: results)
            } catch {
                self.error = error.localizedDescription
                searchResults = []
                originalSearchResults = []
            }
        }
    }

    func bindSearch() {
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
