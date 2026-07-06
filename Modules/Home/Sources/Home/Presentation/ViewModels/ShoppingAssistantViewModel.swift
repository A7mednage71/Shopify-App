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
    private let getBrandsUseCase: any GetBrandsUseCaseProtocol
    private let getCategoriesUseCase: any GetCategoriesUseCaseProtocol
    private let getAssistantResponseUseCase: any GetAssistantResponseUseCaseProtocol
    private var shopProductsCache: [ShopProduct] = []
    private var brandsCache: [Collection] = []
    private var categoriesCache: [Collection] = []

    init(
        getProductsUseCase: any GetProductsUseCaseProtocol,
        getBrandsUseCase: any GetBrandsUseCaseProtocol,
        getCategoriesUseCase: any GetCategoriesUseCaseProtocol,
        getAssistantResponseUseCase: any GetAssistantResponseUseCaseProtocol
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.getBrandsUseCase = getBrandsUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
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
            async let productsTask = getProductsUseCase.execute(first: 100)
            async let brandsTask = getBrandsUseCase.execute(first: 30)
            async let categoriesTask = getCategoriesUseCase.execute(first: 30)
            
            let (fetchedProducts, fetchedBrands, fetchedCategories) = try await (productsTask, brandsTask, categoriesTask)
            
            self.shopProductsCache = fetchedProducts
            self.brandsCache = fetchedBrands
            self.categoriesCache = fetchedCategories
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
                    catalog: shopProductsCache,
                    brands: brandsCache,
                    categories: categoriesCache
                )
                self.messages.append(ChatMessage(
                    role: .assistant,
                    text: reply.reply,
                    productIds: reply.product_ids,
                    brandIds: reply.brand_ids,
                    categoryIds: reply.category_ids
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
    
    func brands(for ids: [String]) -> [Collection] {
        return brandsCache.filter { ids.contains($0.id) }
    }
    
    func categories(for ids: [String]) -> [Collection] {
        return categoriesCache.filter { ids.contains($0.id) }
    }
}
