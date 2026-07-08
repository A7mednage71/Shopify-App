import SwiftUI
import Common

struct SearchBarSection: View {
    @Binding var searchText: String
    var onVoiceSearch: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.appSearchIcon)
                .font(.system(size: 16))
            
            TextField(HomeStrings.Search.placeholder, text: $searchText)
                .font(.searchPlaceholder)
                .foregroundColor(.appTextPrimary)
            
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(Color.appBackgroundWhite)
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}


