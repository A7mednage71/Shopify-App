import SwiftUI
import Common

// MARK: - Horizontal Categories List

struct CategoriesListSection: View {
    let viewModel: HomeViewModel
    let categories: [Collection]
    var onProductTap: ((String) -> Void)? = nil
    var onCategoryTap: ((Collection) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    NavigationLink(destination: CategoryProductsView(category: category, viewModel: viewModel, onProductTap: onProductTap)) {
                        CategoryItem(category: category)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(Color.appBackgroundWhite)
        .cornerRadius(12)
        .padding(.leading, 16)
    }
}

// MARK: - Single Category Item

struct CategoryItem: View {
    let category: Collection

    var body: some View {
        VStack(spacing: 6) {
            CachedImage(urlString: category.imageURL, failureImageName: "category_placeholder")
                .frame(width: 58, height: 58)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.appPrimaryOrange, lineWidth: 1.5)
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
    CategoriesListSection(
        viewModel: HomeAssembler.resolveHomeViewModel(),
        categories: [
            Collection(id: "1", title: "Beauty",  handle: "beauty",  imageURL: "https://picsum.photos/seed/beauty/80/80"),
            Collection(id: "2", title: "Fashion", handle: "fashion", imageURL: "https://picsum.photos/seed/fashion/80/80"),
            Collection(id: "3", title: "Kids",    handle: "kids",    imageURL: "https://picsum.photos/seed/kids/80/80"),
        ]
    )
    .padding(.vertical)
}