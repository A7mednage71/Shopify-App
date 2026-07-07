import SwiftUI
import Common

struct ProductCardView: View {
    let product: ShopProduct
    let onTap: (String) -> Void

    init(product: ShopProduct, onTap: @escaping (String) -> Void) {
        self.product = product
        self.onTap = onTap
    }

    private var sizesLabel: String {
        let sizeOption = product.options.first { option in
            let name = option.name.lowercased()
            return name.contains("size")
        }
        return sizeOption?.values.joined(separator: "/") ?? ""
    }

    private var subtitleLabel: String {
        let categoryOption = product.productType ?? ""
        let colorOption = product.options.first { option in
            let name = option.name.lowercased()
            return name.contains("color")
        }
        let color = colorOption?.values.first ?? ""
        if !color.isEmpty {
            return "\(categoryOption) · \(color)"
        }
        return categoryOption
    }

    private var priceLabel: String {
        if let val = Double(product.price) {
            return String(format: "%.0f", val)
        }
        return product.price
    }

    public var body: some View {
        VStack(spacing: 8) {
            if let vendor = product.vendor, !vendor.isEmpty {
                Text(vendor.uppercased())
                    .font(.assistantProductBadge)
                    .foregroundColor(AppColors.primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(AppColors.primary.opacity(0.1))
                    .clipShape(Capsule())
            }

            // Image display container
            ZStack {
                if let imageURL = product.featuredImageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 70)
                        case .empty, .failure:
                            Text("👟").font(.system(size: 28))
                        @unknown default:
                            EmptyView()
                          }
                      }
                  } else {
                      Text("👟").font(.system(size: 28))
                  }
              }
              .frame(height: 80)
              .frame(maxWidth: .infinity)
              .background(AppColors.backgroundSecondary.opacity(0.5))
              .cornerRadius(8)

              VStack(spacing: 4) {
                  Text(product.title)
                      .font(.assistantProductTitle)
                      .multilineTextAlignment(.center)
                      .foregroundColor(AppColors.textPrimary)
                      .lineLimit(2)
                      .frame(height: 32)

                  if !subtitleLabel.isEmpty {
                      Text(subtitleLabel)
                          .font(.assistantProductSubtitle)
                          .foregroundColor(AppColors.textSecondary)
                          .lineLimit(1)
                  }

                  if !sizesLabel.isEmpty {
                      Text("Sizes: \(sizesLabel)")
                          .font(.assistantProductSizes)
                          .foregroundColor(AppColors.textSecondary)
                          .lineLimit(1)
                  }

                  Text("\(priceLabel) \(product.currencyCode)")
                      .font(.assistantProductPrice)
                      .foregroundColor(AppColors.primary)
                      .padding(.top, 2)
              }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2.5)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appPrimaryOrange.opacity(0.15), lineWidth: 1)
        )
        .onTapGesture {
            onTap(product.id)
        }
    }
}
