import Foundation
import Favorites

extension HomeViewModel {
    
    public func loadFavorites() async {
        do {
            let favorites = try await manageFavoritesUseCase.fetchFavorites()
            self.favoriteProductIDs = Set(favorites.map { $0.id })
        } catch {
            print("Error loading favorites in Home: \(error.localizedDescription)")
        }
    }
    
    public func toggleFavorite(for product: HomeProduct) async {
        let favoriteItem = createFavoriteItem(from: product)
        
        if favoriteProductIDs.contains(favoriteItem.id) {
            await MainActor.run {
                self.productToRemove = favoriteItem
                self.showingRemoveFavoriteAlert = true
            }
        } else {
            await executeToggle(for: favoriteItem)
        }
    }
    
    public func toggleFavorite(for product: ShopProduct) async {
        let favoriteItem = createFavoriteItem(from: product)
        
        if favoriteProductIDs.contains(favoriteItem.id) {
            await MainActor.run {
                self.productToRemove = favoriteItem
                self.showingRemoveFavoriteAlert = true
            }
        } else {
            await executeToggle(for: favoriteItem)
        }
    }
    
    public func confirmRemoveFavorite() async {
        if let item = productToRemove {
            await executeToggle(for: item)
            await MainActor.run {
                self.productToRemove = nil
            }
        }
    }
    
    private func createFavoriteItem(from product: HomeProduct) -> FavoriteProduct {
        let price = Double(product.price) ?? 0.0
        var finalComparePrice: Double? = nil
        if let compareAtStr = product.compareAtPrice, let compareAtDbl = Double(compareAtStr), compareAtDbl > 0 {
            finalComparePrice = compareAtDbl
        }
        return FavoriteProduct(
            id: product.id,
            title: product.title,
            imageURL: product.featuredImageURL ?? "", 
            price: price,
            currencyCode: product.currencyCode,
            compareAtPrice: finalComparePrice,
            rating: product.rating
        )
    }
    
    private func createFavoriteItem(from product: ShopProduct) -> FavoriteProduct {
        let price = Double(product.price) ?? 0.0
        var finalComparePrice: Double? = nil
        if let compareAt = product.compareAtPrice, let compareAtDbl = Double(compareAt), compareAtDbl > 0 {
            finalComparePrice = compareAtDbl
        }
        return FavoriteProduct(
            id: product.id,
            title: product.title,
            imageURL: product.featuredImageURL ?? "", 
            price: price,
            currencyCode: product.currencyCode,
            compareAtPrice: finalComparePrice,
            rating: product.rating
        )
    }
    
    private func executeToggle(for favoriteItem: FavoriteProduct) async {
        do {
            try await manageFavoritesUseCase.toggleFavorite(product: favoriteItem)
            
            if favoriteProductIDs.contains(favoriteItem.id) {
                favoriteProductIDs.remove(favoriteItem.id)
            } else {
                favoriteProductIDs.insert(favoriteItem.id)
            }
        } catch {
            print("Error toggling favorite in Home: \(error.localizedDescription)")
        }
    }
}
