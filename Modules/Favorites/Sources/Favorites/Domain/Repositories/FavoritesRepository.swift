//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Foundation

public protocol FavoritesRepository {
    func getFavorites() async throws -> [FavoriteProduct]
    func addFavorite(_ product: FavoriteProduct) async throws
    func removeFavorite(id: String) async throws
    func isFavorite(id: String) async throws -> Bool
}
