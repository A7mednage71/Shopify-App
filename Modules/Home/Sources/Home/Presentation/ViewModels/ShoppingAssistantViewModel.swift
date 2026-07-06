import Foundation
import Combine

@MainActor
final class ShoppingAssistantViewModel: ObservableObject {
    
    // MARK: - Published State
    @Published var messages: [ChatMessage] = []
    @Published var input: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isCatalogLoading = false
    @Published var catalogError: String?

    // MARK: - Dependencies & Catalog Cache
    private let getProductsUseCase: any GetProductsUseCaseProtocol
    private let getAssistantResponseUseCase: any GetAssistantResponseUseCaseProtocol
    private var shopProductsCache: [ShopProduct] = []

    init(
        getProductsUseCase: any GetProductsUseCaseProtocol,
        getAssistantResponseUseCase: any GetAssistantResponseUseCaseProtocol
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.getAssistantResponseUseCase = getAssistantResponseUseCase
        
        // Add greeting message
        self.messages = [
            ChatMessage(role: .assistant, text: "Welcome to our Sportswear & Shoe Store! 👋 I am your smart AI Shopping Assistant. Tell me what you're looking for — type, color, size, or vendor, and I'll find the best options for you!")
        ]
    }

    // MARK: - Load Live Shopify Catalog
    func loadCatalog() async {
        isCatalogLoading = true
        catalogError = nil
        do {
            // Fetch 50 products from Shopify Storefront API
            let fetchedProducts = try await getProductsUseCase.execute(first: 50)
            self.shopProductsCache = fetchedProducts
        } catch {
            print("Failed to load Shopify Catalog for Assistant:", error)
            self.catalogError = "We couldn't load the product catalog right now. Please check your internet connection and try again."
        }
        isCatalogLoading = false
    }

    // MARK: - Send Message
    func send() {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty, !isLoading else { return }

        // Append user message
        let userMessage = ChatMessage(role: .user, text: trimmedInput)
        messages.append(userMessage)
        input = ""
        isLoading = true
        errorMessage = nil

        Task {
            // If catalog hasn't loaded yet, try loading it first
            if shopProductsCache.isEmpty {
                await loadCatalog()
            }
            
            do {
                let reply = try await getAssistantResponseUseCase.execute(
                    messages: messages,
                    catalog: shopProductsCache
                )
                self.messages.append(ChatMessage(
                    role: .assistant,
                    text: reply.reply,
                    productIds: reply.product_ids
                ))
            } catch {
                errorMessage = AssistantErrorMapper.map(error)
            }
            isLoading = false
        }
    }

    // MARK: - Fetch Products for UI Cards
    func products(for ids: [String]) -> [ShopProduct] {
        return shopProductsCache.filter { ids.contains($0.id) }
    }
}
