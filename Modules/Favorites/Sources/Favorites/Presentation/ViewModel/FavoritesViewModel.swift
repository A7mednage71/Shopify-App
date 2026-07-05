//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Foundation
import Combine

@MainActor
public final class FavoritesViewModel: ObservableObject {
    @Published public var favoriteProducts: [FavoriteProduct] = []
    @Published public var isLoading: Bool = false
    
    private let useCase: ManageFavoritesUseCase
    
    public init(useCase: ManageFavoritesUseCase) {
        self.useCase = useCase
    }
    
    public func loadFavorites() {
        isLoading = true
        Task {
            do {
                let products = try await useCase.fetchFavorites()
                self.favoriteProducts = products
                self.isLoading = false
            } catch {
                print("Error loading favorites: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
    
    public func removeFavorite(product: FavoriteProduct) {
        Task {
            do {
                try await useCase.toggleFavorite(product: product)
                loadFavorites()
            } catch {
                print("Error removing favorite: \(error.localizedDescription)")
            }
        }
    }
}
