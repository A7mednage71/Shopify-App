import SwiftUI
import Common

// MARK: - Horizontal Brands List

struct BrandsListSection: View {
    let viewModel: HomeViewModel
    let brands: [Collection]
    var onProductTap: ((String) -> Void)? = nil
    var performProtectedAction: (@escaping () -> Void) -> Void = { action in action() }
    var onBrandTap: ((Collection) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(brands) { brand in
                    NavigationLink(
                        destination: VendorProductsView(
                            vendorName: brand.title,
                            viewModel: viewModel,
                            onProductTap: onProductTap,
                            performProtectedAction: performProtectedAction
                        )
                    ) {
                        BrandItem(brand: brand)
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

// MARK: - Single Brand Item

struct BrandItem: View {
    let brand: Collection

    var body: some View {
        VStack(spacing: 6) {
            if let imageURL = brand.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .empty:
                        Circle()
                            .fill(Color.appBackgroundGray)
                            .overlay(
                                ProgressView()
                                    .tint(.appPrimaryOrange)
                            )
                    case .failure:
                        Image("category_placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 58, height: 58)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.appPrimaryOrange, lineWidth: 1.5)
                )
            } else {
                Image("category_placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 58, height: 58)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.appPrimaryOrange, lineWidth: 1.5)
                    )
            }

            Text(brand.title)
                .categoryLabelStyle()
                .lineLimit(1)
        }
        .frame(width: 65)
    }
}
