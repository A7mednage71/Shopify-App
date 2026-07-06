//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Swinject

public final class FavoritesPresentationAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(FavoritesViewModel.self) { resolver in
            let useCase = resolver.resolve(ManageFavoritesUseCase.self)!
            return FavoritesViewModel(useCase: useCase)
        }.inObjectScope(.container)
        
        container.register(FavoritesViewFactory.self) { resolver in
            let viewModel = resolver.resolve(FavoritesViewModel.self)!
            return FavoritesViewFactory(viewModel: viewModel)
        }
    }
}
