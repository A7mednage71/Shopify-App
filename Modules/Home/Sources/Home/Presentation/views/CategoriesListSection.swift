import SwiftUI
import Common

// MARK: - Horizontal Categories List

struct CategoriesListSection: View {
    let categories: [ShopifyCollection]
    var onCategoryTap: ((ShopifyCollection) -> Void)? = nil

    var body: some View {
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


