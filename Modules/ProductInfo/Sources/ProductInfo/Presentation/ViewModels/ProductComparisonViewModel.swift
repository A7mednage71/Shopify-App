import Foundation

@MainActor
final class ProductComparisonViewModel: ObservableObject {
    @Published private(set) var candidatesState: ProductComparisonCandidatesState = .idle
    @Published private(set) var recommendationState: ProductComparisonRecommendationState = .idle
    @Published private(set) var selectedProduct: ProductDetails?
    @Published var searchText = ""
    @Published var comparisonPreference = ""
    @Published var isPreferenceExpanded = false
    @Published private(set) var displayedRecommendationText = ""

    private let getComparableProductsUseCase: any GetComparableProductsUseCaseProtocol
    private let getRecommendationUseCase: any GetProductComparisonRecommendationUseCaseProtocol

    init(
        getComparableProductsUseCase: any GetComparableProductsUseCaseProtocol,
        getRecommendationUseCase: any GetProductComparisonRecommendationUseCaseProtocol
    ) {
        self.getComparableProductsUseCase = getComparableProductsUseCase
        self.getRecommendationUseCase = getRecommendationUseCase
    }

    var candidates: [ProductDetails] {
        guard case .loaded(let products) = candidatesState else { return [] }
        return products
    }

    var filteredCandidates: [ProductDetails] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return candidates }

        return candidates.filter {
            $0.title.localizedCaseInsensitiveContains(query)
        }
    }

    func loadCandidates(for currentProduct: ProductDetails) async {
        guard currentProduct.normalizedProductType.isComparable else {
            candidatesState = .idle
            return
        }

        candidatesState = .loading
        recommendationState = .idle
        selectedProduct = nil
        displayedRecommendationText = ""

        do {
            let products = try await getComparableProductsUseCase.execute(currentProduct: currentProduct, first: 50)
            candidatesState = products.isEmpty ? .empty : .loaded(products)
        } catch {
            candidatesState = .failure(error.localizedDescription)
        }
    }

    func select(_ product: ProductDetails) {
        selectedProduct = product
        recommendationState = .idle
        displayedRecommendationText = ""
    }

    func clearSelection() {
        selectedProduct = nil
        recommendationState = .idle
        displayedRecommendationText = ""
    }

    func requestRecommendation(currentProduct: ProductDetails) async {
        guard let selectedProduct else { return }

        recommendationState = .loading
        displayedRecommendationText = ""

        do {
            let recommendation = try await getRecommendationUseCase.execute(
                currentProduct: currentProduct,
                selectedProduct: selectedProduct,
                preference: comparisonPreference
            )
            recommendationState = .success(recommendation)
            await revealRecommendationText(recommendation.explanation)
        } catch {
            recommendationState = .failure(error.localizedDescription)
        }
    }

    func resetForDismissal() {
        searchText = ""
        comparisonPreference = ""
        isPreferenceExpanded = false
        selectedProduct = nil
        recommendationState = .idle
        displayedRecommendationText = ""
    }

    private func revealRecommendationText(_ text: String) async {
        displayedRecommendationText = ""

        for character in text {
            displayedRecommendationText.append(character)
            try? await Task.sleep(nanoseconds: 12_000_000)
        }
    }
}
