import SwiftUI

// MARK: - Category / Collections Section
// Shopify API: collections query (Storefront API)
// GraphQL: { collections(first: 10) { nodes { id title handle image { url } } } }

struct CategorySection: View {
    let categories: [ShopifyCollection]
    var onCategoryTap: ((ShopifyCollection) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Header
            HStack {
                Text("All Featured")
                    .sectionTitleStyle()
                
                Spacer()
                
                // Sort Button
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Text("Sort")
                            .font(.buttonSmall)
                            .foregroundColor(.textSecondary)
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 11))
                            .foregroundColor(.textSecondary)
                    }
                }
                
                // Filter Button
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Text("Filter")
                            .font(.buttonSmall)
                            .foregroundColor(.textSecondary)
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 11))
                            .foregroundColor(.textSecondary)
                    }
                }
            }
            .padding(.horizontal, 16)
            
            // Horizontal scrolling categories
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(categories) { category in
                        CategoryItem(category: category)
                            .onTapGesture {
                                onCategoryTap?(category)
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - Single Category Item
struct CategoryItem: View {
    let category: ShopifyCollection
    
    var body: some View {
        VStack(spacing: 6) {
            // Category Image (circular)
            AsyncImage(url: URL(string: category.imageURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.backgroundGray)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.textTertiary)
                            .font(.system(size: 22))
                    )
            }
            .frame(width: 58, height: 58)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.borderLight, lineWidth: 1)
            )
            
            // Category Label
            Text(category.title)
                .categoryLabelStyle()
                .lineLimit(1)
        }
        .frame(width: 65)
    }
}

// MARK: - Preview
#Preview {
    CategorySection(categories: MockShopifyData.categories)
        .padding(.vertical)
}
