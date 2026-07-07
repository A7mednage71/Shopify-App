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
        let price = Double(product.price) ?? 0.0
        
        var finalComparePrice: Double? = nil
        if let compareAtStr = product.compareAtPrice, let compareAtDbl = Double(compareAtStr), compareAtDbl > 0 {
            finalComparePrice = compareAtDbl
        }
        
        let favoriteItem = FavoriteProduct(
            id: product.id,
            title: product.title,
            imageURL: product.featuredImageURL ?? "", 
            price: price,
            currencyCode: product.currencyCode,
            compareAtPrice: finalComparePrice,
            rating: product.rating
        )
        
        await executeToggle(for: favoriteItem)
    }
    
    public func toggleFavorite(for product: ShopProduct) async {
        let price = Double(product.price) ?? 0.0
        
        var finalComparePrice: Double? = nil
        if let compareAt = product.compareAtPrice, let compareAtDbl = Double(compareAt), compareAtDbl > 0 {
            finalComparePrice = compareAtDbl
        }
        
        let favoriteItem = FavoriteProduct(
            id: product.id,
            title: product.title,
            imageURL: product.featuredImageURL ?? "", 
            price: price,
            currencyCode: product.currencyCode,
            compareAtPrice: finalComparePrice,
            rating: product.rating
        )
        
        await executeToggle(for: favoriteItem)
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
