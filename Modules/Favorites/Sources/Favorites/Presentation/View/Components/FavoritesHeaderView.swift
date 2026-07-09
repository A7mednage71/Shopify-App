import SwiftUI
import Common

struct FavoritesHeaderView: View {
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {            
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(L10n.Fav.favorites)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.appTextPrimary)
                
                if count > 0 {
                    Text("(\(count))")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.appTextSecondary)
                }
            }
            
            Text(L10n.Fav.browseSaved)
                .font(.system(size: 13))
                .foregroundColor(.appTextSecondary)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }
}
