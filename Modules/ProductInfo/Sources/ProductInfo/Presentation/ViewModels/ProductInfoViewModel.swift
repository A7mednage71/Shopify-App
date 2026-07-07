import Common
import SwiftUI
import Favorites

@MainActor
public final class ProductInfoViewModel: ObservableObject {
    @Published public private(set) var state: ProductInfoViewState = .idle
    @Published public private(set) var addToCartState: ProductInfoAddToCartState = .idle
    @Published public var isFavorite: Bool = false
    
    private let getProductInfoUseCase: any GetProductInfoUseCaseProtocol
    private let addItemToCartUseCase: any AddItemToCartUseCaseProtocol
    private let manageFavoritesUseCase: any ManageFavoritesUseCase

    init(
        getProductInfoUseCase: any GetProductInfoUseCaseProtocol,
        addItemToCartUseCase: any AddItemToCartUseCaseProtocol,
        manageFavoritesUseCase: any ManageFavoritesUseCase
    ) {
        self.getProductInfoUseCase = getProductInfoUseCase
        self.addItemToCartUseCase = addItemToCartUseCase
        self.manageFavoritesUseCase = manageFavoritesUseCase
    }

    public func loadProduct(id: String) async {
        state = .loading

        do {
            let product = try await getProductInfoUseCase.execute(productID: id)
            state = .success(product)
            isFavorite = try await manageFavoritesUseCase.checkIsFavorite(id: id)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    public func addToCart(variant: ProductVariant?, quantity: Int) async {
        guard let variant else {
            addToCartState = .failure(ProductInfoText.selectAvailableVariantMessage)
            return
        }

        addToCartState = .loading

        do {
            let cart = try await addItemToCartUseCase.execute(
                input: AddCartItemInput(
                    variantID: variant.id,
                    quantity: quantity,
                    availableQuantity: variant.quantityAvailable
                )
            )

            addToCartState = .success(cart)
        } catch {
            addToCartState = .failure(error.localizedDescription)
        }
    }

    public func toggleFavorite(product: ProductDetails) async {
            let priceString = product.priceRange.minVariantPrice.amount
            let price = Double(priceString) ?? 0.0
            let currency = product.priceRange.minVariantPrice.currencyCode
            let comparePriceString = product.compareAtPrice.amount
            let comparePrice = Double(comparePriceString)
            let finalComparePrice = (comparePrice == 0.0) ? nil : comparePrice
            
            let favoriteItem = FavoriteProduct(
                id: product.id,
                title: product.title,
                imageURL: product.images.first?.url ?? "",
                price: price,
                currencyCode: currency,
                compareAtPrice: finalComparePrice,
                rating: product.reviewSummary.averageRating
            )
            
            do {
                try await manageFavoritesUseCase.toggleFavorite(product: favoriteItem)
                isFavorite.toggle() 
            } catch {
                print("Error toggling favorite: \(error.localizedDescription)")
            }
        }
}
