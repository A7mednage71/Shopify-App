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
            CachedImage(urlString: brand.imageURL, failureImageName: "brand_placeholder")
                .frame(width: 58, height: 58)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.appPrimaryOrange, lineWidth: 1.5)
                )

            Text(brand.title)
                .categoryLabelStyle()
                .lineLimit(1)
        }
        .frame(width: 65)
    }
}
