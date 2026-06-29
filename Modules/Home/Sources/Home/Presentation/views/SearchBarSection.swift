import SwiftUI

// MARK: - Search Bar Section
// Shopify: Links to Storefront Search API → /search?q={query}

struct SearchBarSection: View {
    @Binding var searchText: String
    var onVoiceSearch: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.searchIcon)
                .font(.system(size: 16))
            
            TextField("Search any Product...", text: $searchText)
                .font(.searchPlaceholder)
                .foregroundColor(.textPrimary)
            
            Spacer()
            
            Button(action: { onVoiceSearch?() }) {
                Image(systemName: "mic.fill")
                    .foregroundColor(.searchIcon)
                    .font(.system(size: 16))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(Color.searchBackground)
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
#Preview {
    SearchBarSection(searchText: .constant(""))
        .padding(.vertical)
}
