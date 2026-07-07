//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Foundation
import CoreData
import Persistence

public final class FavoritesRepositoryImpl: FavoritesRepository {
    private let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func getFavorites() async throws -> [FavoriteProduct] {
        return try await context.perform {
            let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
            let items = try self.context.fetch(request)
            
            return items.map { item in
                FavoriteProduct(
                    id: item.id ?? "",
                    title: item.title ?? "",
                    imageURL: item.imageURL ?? "",
                    price: item.price,
                    currencyCode: item.currencyCode ?? "USD",
                    compareAtPrice: item.compareAtPrice > 0 ? item.compareAtPrice : nil,
                    rating: item.rating > 0 ? item.rating : nil
                )
            }
        }
    }
    
    public func addFavorite(_ product: FavoriteProduct) async throws {
        try await context.perform {
            if try self.checkIsFavorite(id: product.id) { return }
            
            let newItem = FavoriteItem(context: self.context)
            newItem.id = product.id
            newItem.title = product.title
            newItem.imageURL = product.imageURL
            newItem.price = product.price
            newItem.currencyCode = product.currencyCode
            
            if let comparePrice = product.compareAtPrice {
                newItem.compareAtPrice = comparePrice
            }
            
            if let rating = product.rating {
                newItem.rating = rating
            }
            
            try self.context.save()
        }
    }
    
    public func removeFavorite(id: String) async throws {
        try await context.perform {
            let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            
            let results = try self.context.fetch(request)
            for item in results {
                self.context.delete(item)
            }
            
            if self.context.hasChanges {
                try self.context.save()
            }
        }
    }
    
    public func isFavorite(id: String) async throws -> Bool {
        try await context.perform {
            return try self.checkIsFavorite(id: id)
        }
    }
    
    private func checkIsFavorite(id: String) throws -> Bool {
        let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let count = try self.context.count(for: request)
        return count > 0
    }
}
