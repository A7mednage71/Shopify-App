//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import SwiftUI

public struct FavoritesViewFactory {
    private let viewModel: FavoritesViewModel
    
    public init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    @MainActor
    public func makeFavoritesDestinationView(onProductTap: @escaping (String) -> Void) -> some View {
            FavoritesView(viewModel: viewModel, onProductTap: onProductTap)
        }
}
