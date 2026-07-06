//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Foundation

public protocol ManageFavoritesUseCase {
    func toggleFavorite(product: FavoriteProduct) async throws
    func checkIsFavorite(id: String) async throws -> Bool
    func fetchFavorites() async throws -> [FavoriteProduct]
}

public final class ManageFavoritesUseCaseImpl: ManageFavoritesUseCase {
    private let repository: FavoritesRepository
    
    public init(repository: FavoritesRepository) {
        self.repository = repository
    }
    
    public func toggleFavorite(product: FavoriteProduct) async throws {
        let isFav = try await repository.isFavorite(id: product.id)
        if isFav {
            try await repository.removeFavorite(id: product.id)
        } else {
            try await repository.addFavorite(product)
        }
    }
    
    public func checkIsFavorite(id: String) async throws -> Bool {
        return try await repository.isFavorite(id: id)
    }
    
    public func fetchFavorites() async throws -> [FavoriteProduct] {
        return try await repository.getFavorites()
    }
}
