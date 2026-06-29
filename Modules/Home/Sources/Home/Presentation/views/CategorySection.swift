import SwiftUI
import Common

// MARK: - Category / Collections Section

struct CategorySection: View {
    let categories: [ShopifyCollection]
    var onCategoryTap: ((ShopifyCollection) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text(HomeStrings.Category.sectionTitle)
                    .sectionTitleStyle()
                
                Spacer()
                
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Text(HomeStrings.Category.sortButton)
                            .font(.buttonSmall)
                            .foregroundColor(.appTextSecondary)
                        
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 11))
                            .foregroundColor(.appTextSecondary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.appBackgroundWhite)
                    .cornerRadius(6)
                    .shadow(color: Color.appCardShadow, radius: 4, x: 0, y: 1)
                }
                
                // Filter Button
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Text(HomeStrings.Category.filterButton)
                            .font(.buttonSmall)
                            .foregroundColor(.appTextSecondary)
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 11))
                            .foregroundColor(.appTextSecondary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.appBackgroundWhite)
                    .cornerRadius(6)
                    .shadow(color: Color.appCardShadow, radius: 4, x: 0, y: 1)
                }
            }
            .padding(.horizontal, 16)
            
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
                .padding(.vertical, 14)
            }
            .background(Color.appBackgroundWhite)
            .cornerRadius(12)
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Single Category Item
struct CategoryItem: View {
    let category: ShopifyCollection
    
    var body: some View {
        VStack(spacing: 6) {
            AsyncImage(url: URL(string: category.imageURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.appBackgroundGray)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.appTextTertiary)
                            .font(.system(size: 22))
                    )
            }
            .frame(width: 58, height: 58)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.appBorderLight, lineWidth: 1)
            )
            
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
