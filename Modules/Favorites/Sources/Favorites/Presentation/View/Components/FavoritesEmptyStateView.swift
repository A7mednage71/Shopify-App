import SwiftUI
import Common

struct FavoritesEmptyStateView: View {
    let illustrationScale: CGFloat

    init(illustrationScale: CGFloat = 1.0) {
        self.illustrationScale = illustrationScale
    }

    var body: some View {
        VStack(spacing: 16) {
            Image("no_favourites", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.gray.opacity(0.5))
                .scaleEffect(illustrationScale)
                .padding(.top, 40)
            
            Text("No Favorites Yet")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Tap the heart icon on any product to save it here.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity)
    }
}
