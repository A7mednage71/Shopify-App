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
                        .scaleEffect(illustrationScale)
                        .onAppear {
                            startIllustrationAnimation()
                        }
                        .onChange(of: reduceMotion) { _ in
                            startIllustrationAnimation()
                        }
                    
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
                                productToDelete = product
                                showDeleteAlert = true
                            }
                            .onTapGesture {
                                onProductTap(product.id)
                            }
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .padding()
                    .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.favoriteProducts)
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.large)
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
