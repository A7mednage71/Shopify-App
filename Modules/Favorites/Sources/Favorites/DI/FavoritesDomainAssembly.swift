//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Foundation
import Swinject

public final class FavoritesDomainAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(ManageFavoritesUseCase.self) { resolver in
            let repository = resolver.resolve(FavoritesRepository.self)!
            return ManageFavoritesUseCaseImpl(repository: repository)
        }
    }
}
