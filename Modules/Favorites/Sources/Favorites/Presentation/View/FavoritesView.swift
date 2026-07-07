//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import SwiftUI
import Common

public struct FavoritesView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @ObservedObject private var viewModel: FavoritesViewModel
    @State private var illustrationScale: CGFloat = 0.98
    @State private var showDeleteAlert = false
    @State private var productToDelete: FavoriteProduct?
    let onProductTap: (String) -> Void
    
    public init(viewModel: FavoritesViewModel, onProductTap: @escaping (String) -> Void) {
        self.viewModel = viewModel 
        self.onProductTap = onProductTap
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                FavoritesHeaderView(count: viewModel.favoriteProducts.count)
                
                if viewModel.isLoading && viewModel.favoriteProducts.isEmpty {
                    FavoritesSkeletonView()
                } else if viewModel.favoriteProducts.isEmpty {
                    FavoritesEmptyStateView(illustrationScale: illustrationScale)
                        .onAppear {
                            startIllustrationAnimation()
                        }
                        .onChange(of: reduceMotion) { _ in
                            startIllustrationAnimation()
                        }
                } else {
                    FavoritesGridSection(
                        products: viewModel.favoriteProducts,
                        onProductTap: onProductTap,
                        onRemove: { product in
                            productToDelete = product
                            showDeleteAlert = true
                        }
                    )
                    .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.favoriteProducts)
                }
            }
        }
        .background(Color.appBackgroundGray)
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadFavorites()
        }
        .alert("Remove from Favorites", isPresented: $showDeleteAlert, presenting: productToDelete) { product in
            Button("Cancel", role: .cancel) {
                productToDelete = nil
            }
            Button("Remove", role: .destructive) {
                viewModel.removeFavorite(product: product)
            }
        } message: { product in
            Text("Are you sure you want to remove '\(product.title)' from your favorites?")
        }
    }

    private func startIllustrationAnimation() {
        guard !reduceMotion else {
            illustrationScale = 1.0
            return
        }

        illustrationScale = 0.98
        withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
            illustrationScale = 1.03
        }
    }
}
