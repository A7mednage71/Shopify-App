import SwiftUI
import Common

// MARK: - Horizontal Categories List

struct CategoriesListSection: View {
    let viewModel: HomeViewModel
    let categories: [Collection]
    var onCategoryTap: ((Collection) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    NavigationLink(destination: VendorProductsView(vendorName: category.title, viewModel: viewModel)) {
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
        .padding(.horizontal, 16)
    }
}

// MARK: - Single Category Item

struct CategoryItem: View {
    let category: Collection

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