import SwiftUI
import Common

// MARK: - Horizontal Brands List

struct BrandsListSection: View {
    let viewModel: HomeViewModel
    let brands: [Collection]
    var onBrandTap: ((Collection) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(brands) { brand in
                    NavigationLink(destination: VendorProductsView(vendorName: brand.title, viewModel: viewModel)) {
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
        .padding(.horizontal, 16)
    }
}

// MARK: - Single Brand Item

struct BrandItem: View {
    let brand: Collection

    var body: some View {
        VStack(spacing: 6) {
            AsyncImage(url: URL(string: brand.imageURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.appBackgroundGray)
                    .overlay(
                        Image(systemName: "tag.fill")
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

            Text(brand.title)
                .categoryLabelStyle()
                .lineLimit(1)
        }
        .frame(width: 65)
    }
}
