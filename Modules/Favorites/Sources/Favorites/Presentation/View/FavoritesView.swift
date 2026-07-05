//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import SwiftUI
import Common

public struct FavoritesView: View {
    @ObservedObject private var viewModel: FavoritesViewModel
    let onProductTap: (String) -> Void
    
    public init(viewModel: FavoritesViewModel, onProductTap: @escaping (String) -> Void) {
        self.viewModel = viewModel 
        self.onProductTap = onProductTap
    }
    
    public var body: some View {
        ZStack {
            if viewModel.isLoading && viewModel.favoriteProducts.isEmpty {
                ProgressView()
                    .scaleEffect(1.5)
            } else if viewModel.favoriteProducts.isEmpty {
                VStack(spacing: 16) {
                    Image("no_favorites", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No Favorites Yet")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Tap the heart icon on any product to save it here.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.favoriteProducts) { product in
                            FavoriteProductCard(product: product) {
                                viewModel.removeFavorite(product: product)
                            }
                            .onTapGesture {
                                onProductTap(product.id)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}
