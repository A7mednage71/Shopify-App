import SwiftUI
import Common

// MARK: - Horizontal Categories List

struct CategoriesListSection: View {
    let viewModel: HomeViewModel
    let categories: [Collection]
    var onProductTap: ((String) -> Void)? = nil
    var performProtectedAction: (@escaping () -> Void) -> Void = { action in action() }
    var onCategoryTap: ((Collection) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    NavigationLink(
                        destination: CategoryProductsView(
                            category: category,
                            viewModel: viewModel,
                            onProductTap: onProductTap,
                            performProtectedAction: performProtectedAction
                        )
                    ) {
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
