import SwiftUI
import Common

struct FavoritesHeaderView: View {
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.appPrimaryOrange)
                    .font(.system(size: 14))
                Text("My Wishlist")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.appPrimaryOrange)
                    .textCase(.uppercase)
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("Favorites")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.appTextPrimary)
                
                if count > 0 {
                    Text("(\(count))")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.appTextSecondary)
                }
            }
            
            Text("Browse all items you've saved to your favorites")
                .font(.system(size: 13))
                .foregroundColor(.appTextSecondary)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }
}
