import Foundation
import SwiftUI
import Combine

// MARK: - HomeViewModel

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Published State
    @Published var searchText: String = ""
    @Published private(set) var searchResults: [ShopifyProduct] = []
    @Published private(set) var isSearching: Bool = false

    // MARK: - Data (replace with real repository calls)
    let allProducts: [ShopifyProduct] = MockShopifyData.allProducts
    let totalItemCount: Int = MockShopifyData.allProducts.count

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Debounce search so it doesn't fire on every keystroke
        $searchText
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }

    // MARK: - Search Logic
    private func performSearch(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespaces)
        isSearching = !trimmed.isEmpty

        guard !trimmed.isEmpty else {
            searchResults = []
            return
        }

        let lower = trimmed.lowercased()
        searchResults = allProducts.filter {
            $0.title.lowercased().contains(lower) ||
            $0.description.lowercased().contains(lower)
        }
    }

    // MARK: - Formatted Count Label
    var resultCountLabel: String {
        let count = isSearching ? searchResults.count : totalItemCount
        return formatCount(count) + "+ Items"
    }

    private func formatCount(_ n: Int) -> String {
        if n >= 1_000_000 {
            return String(format: "%.1fM", Double(n) / 1_000_000)
        } else if n >= 1_000 {
            return String(format: "%.0fK", Double(n) / 1_000)
        }
        return "\(n)"
    }
}
