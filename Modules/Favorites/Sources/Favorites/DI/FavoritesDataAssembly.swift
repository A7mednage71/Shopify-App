//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Foundation
import Swinject
import Persistence
import CoreData

public final class FavoritesDataAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(FavoritesRepository.self) { resolver in
            let context = PersistenceController.shared.viewContext
            return FavoritesRepositoryImpl(context: context)
        }
    }
}
